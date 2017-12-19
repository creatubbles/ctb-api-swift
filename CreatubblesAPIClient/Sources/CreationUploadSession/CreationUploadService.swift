//
//  CreationUploadService.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2017 Creatubbles Pte. Ltd.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

protocol CreationUploadServiceDelegate: class {
    func creationUploadService(_ sender: CreationUploadService, newSessionAdded session: CreationUploadSession)
    func creationUploadService(_ sender: CreationUploadService, uploadFinished session: CreationUploadSession)
    func creationUploadService(_ sender: CreationUploadService, uploadFailed session: CreationUploadSession, withError error: Error)
    func creationUploadService(_ sender: CreationUploadService, progressChanged session: CreationUploadSession, completedUnitCount: Int64, totalUnitcount: Int64, fractionCompleted: Double)
}

class CreationUploadService: CreationUploadSessionDelegate {
    weak var delegate: CreationUploadServiceDelegate?

    fileprivate let databaseDAO: DatabaseDAO
    fileprivate let requestSender: RequestSender
    fileprivate var uploadSessions: Array<CreationUploadSession>
    fileprivate let operationQueue: OperationQueue
    fileprivate let preparationQueue: OperationQueue

    init(requestSender: RequestSender) {
        self.requestSender = requestSender
        self.databaseDAO = DatabaseDAO()
        self.uploadSessions = Array<CreationUploadSession>()
        
        self.operationQueue = OperationQueue()
        self.operationQueue.maxConcurrentOperationCount = 1
        
        // To make sure that upload sessions can be retried we have to define a preparation stage. Basically, it's responsible for saving are required data locally and shouldn't be related to API calls.
        self.preparationQueue = OperationQueue()
        self.preparationQueue.maxConcurrentOperationCount = 1
        
        setupSessions()
    }

    fileprivate func setupSessions() {
        uploadSessions = databaseDAO.fetchAllCreationUploadSessions(requestSender)
        uploadSessions.forEach({ $0.delegate = self })
    }

    func getAllActiveUploadSessionsPublicData() -> Array<CreationUploadSessionPublicData> {
        return uploadSessions.filter({ $0.isActive == true && $0.state != .cancelled }).map({ CreationUploadSessionPublicData(creationUploadSession: $0) })
    }

    func getAllNotFinishedUploadSessionsPublicData() -> Array<CreationUploadSessionPublicData> {
        return uploadSessions.filter({ $0.state.rawValue < CreationUploadSessionState.serverNotified.rawValue })
            .map({ CreationUploadSessionPublicData(creationUploadSession: $0) })
    }

    func getAllFinishedUploadSessionPublicData() -> Array<CreationUploadSessionPublicData> {
        return uploadSessions.filter({ $0.state == .serverNotified }).map({ CreationUploadSessionPublicData(creationUploadSession: $0) })
    }

    func startAllNotFinishedUploadSessions(_ completion: CreationClosure?) {
        // Before we start all unfinished sessions we have make sure that upload sessions has a correct state
        migrateUploadSessionsIfNeeded()
        
        var newUploadSessions: [CreationUploadSession] = []
        databaseDAO.fetchAllCreationUploadSessions(requestSender).forEach { (uploadSession) in
            if uploadSessions.filter({ $0.localIdentifier == uploadSession.localIdentifier }).isEmpty {
                uploadSession.delegate = self
                newUploadSessions.append(uploadSession)
            }
        }

        uploadSessions.append(contentsOf: newUploadSessions)
        uploadSessions.filter({ !$0.isActive }).forEach { (uploadSession) in
            let operation = CreationUploadSessionOperation(session: uploadSession, completion: completion)
            operationQueue.addOperation(operation)
        }

    }

    func startUploadSession(sessionIdentifier sessionId: String) {
        guard let session = uploadSessions.filter({ $0.localIdentifier == sessionId }).first
        else {
            Logger.log(.warning, "Cannot find session with identifier \(sessionId) to start")
            return
        }

        session.delegate = self
        session.start(nil)
    }

    func removeUploadSession(sessionIdentifier sessionId: String) {
        guard let session = uploadSessions.filter({ $0.localIdentifier == sessionId }).first,
              let index = uploadSessions.index(of: session)
        else {
            Logger.log(.warning, "Cannot find session with identifier \(sessionId) to remove")
            return
        }

        session.delegate = nil
        session.cancel()
        uploadSessions.remove(at: index)
        databaseDAO.removeUploadSession(withIdentifier: sessionId)
        delegate?.creationUploadService(self, uploadFailed: session, withError: APIClientError.genericUploadCancelledError as Error)
    }

    func removeAllUploadSessions() {
        uploadSessions.forEach {
            $0.delegate = nil
            $0.cancel()
        }
        databaseDAO.removeAllUploadSessions()
        uploadSessions = databaseDAO.fetchAllCreationUploadSessions(requestSender)
    }

    func uploadCreation(data: NewCreationData, preparationCompletion: ((_ error: Error?) -> Void)?, completion: CreationClosure?) -> CreationUploadSessionPublicData? {
        let session = CreationUploadSession(data: data, requestSender: requestSender)
        if let _ = uploadSessions.filter({ $0.localIdentifier == data.localIdentifier }).first {
            let error = APIClientError.duplicatedUploadLocalIdentifierError
            preparationCompletion?(error)
            completion?(nil, error)
            delegate?.creationUploadService(self, uploadFailed: session, withError: error)

            return nil
        }

        // Before adding a new upload session we have to make sure that it has been prepared correctly. This step is required to have a possibility to retry the upload sessions at the later stage (i.e. reopening the app)
        let operation = BlockOperation()
        operation.addExecutionBlock { [unowned operation, weak self] in
            guard !operation.isCancelled else {
                let error = APIClientError.genericUploadCancelledError
                preparationCompletion?(error)
                completion?(nil, error)
                return
            }
            
            session.prepare() { [weak self] (error) in
                guard let strongSelf = self, error == nil else {
                    preparationCompletion?(error)
                    completion?(nil, APIClientError.genericUploadCancelledError)
                    return
                }
                
                DispatchQueue.main.async {
                    strongSelf.uploadSessions.append(session)
                    strongSelf.databaseDAO.saveCreationUploadSessionToDatabase(session)
                    session.delegate = strongSelf
                    strongSelf.delegate?.creationUploadService(strongSelf, newSessionAdded: session)
                
                    let operation = CreationUploadSessionOperation(session: session, completion: completion)
                    strongSelf.operationQueue.addOperation(operation)
                
                    preparationCompletion?(nil)
                }
            }
        }
        
        preparationQueue.addOperation(operation)
        
        return CreationUploadSessionPublicData(creationUploadSession: session)
    }

    open func refreshCreationStatusInUploadSession(sessionId: String) {
        let sessions = uploadSessions.filter({ $0.localIdentifier == sessionId })
        sessions.forEach({ $0.refreshCreation(completion: nil) })
    }

    open func refreshCreationStatusInUploadSession(creationId: String) {
        let sessions = uploadSessions.filter({ $0.creation?.identifier == creationId })
        sessions.forEach({ $0.refreshCreation(completion: nil) })
    }

    // MARK: - CreationUploadSessionDelegate
    func creationUploadSessionChangedState(_ creationUploadSession: CreationUploadSession) {
        databaseDAO.saveCreationUploadSessionToDatabase(creationUploadSession)
        if(creationUploadSession.isAlreadyFinished) {
            delegate?.creationUploadService(self, uploadFinished: creationUploadSession)
        }
    }

    func creationUploadSessionChangedProgress(_ creationUploadSession: CreationUploadSession, completedUnitCount: Int64, totalUnitcount totalUnitCount: Int64, fractionCompleted: Double) {
        delegate?.creationUploadService(self, progressChanged: creationUploadSession, completedUnitCount: completedUnitCount, totalUnitcount: totalUnitCount, fractionCompleted: fractionCompleted)
    }

    func creationUploadSessionUploadFailed(_ creationUploadSession: CreationUploadSession, error: Error) {
        delegate?.creationUploadService(self, uploadFailed: creationUploadSession, withError: error)
    }
    
    // MARK: - Migration
    
    private func migrateUploadSessionsIfNeeded() {
        var migratedUploadSessions: [CreationUploadSession] = []
        var invalidUploadSessions: [CreationUploadSession] = []
        databaseDAO.fetchAllCreationUploadSessions(requestSender).forEach { (uploadSession) in
            let migrations: [CreationUploadSessionMigrating] = [CreationUploadSessionDataTypeMigration(session: uploadSession, databaseDAO: databaseDAO), CreationUploadSessionMoveFileMigration(session: uploadSession, databaseDAO: databaseDAO)]
            var error: Error?
            var atLeastOneMigrationExecuted: Bool = false
            migrations.forEach({ (migration) in
                migration.start()
            
                if !atLeastOneMigrationExecuted { atLeastOneMigrationExecuted = migration.executed }
                if error == nil { error = migration.error }
            })
            
            // Update upload session only if there at least one migration executed
            if atLeastOneMigrationExecuted, error == nil {
                migratedUploadSessions.append(uploadSession)
            } else if let _ = error {
                invalidUploadSessions.append(uploadSession)
            }
        }
        
        migratedUploadSessions.forEach { (session) in
            if let existingUploadSession = uploadSessions.filter({ $0.localIdentifier == session.localIdentifier }).first, let index = uploadSessions.index(of: existingUploadSession) {
                uploadSessions[index] = session
            }
        }
        
        // If we cannot execute a migration it means that upload session is invalid. This case can lead to awkward issues that would be really hard to track. This is an edge case and to avoid crashing the app the best way is to delete those objects.
        invalidUploadSessions.forEach { (session) in
            if let existingUploadSession = uploadSessions.filter({ $0.localIdentifier == session.localIdentifier }).first, let index = uploadSessions.index(of: existingUploadSession) {
                uploadSessions.remove(at: index)
                databaseDAO.removeUploadSession(withIdentifier: existingUploadSession.localIdentifier)
            }
        }
    }
}
