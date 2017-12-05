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
    fileprivate static let currentStructureVersionKey = "CreationUploadDAO.currentStructureVersion"
    
    // We are versioning this class to avoid some unexpected crashes after applying some breaking changes. We should increase it if there is a possibility that some stored upload session objects are not valid anymore
    fileprivate let structureVersion = 1
    
    weak var delegate: CreationUploadServiceDelegate?

    fileprivate let databaseDAO: DatabaseDAO
    fileprivate let requestSender: RequestSender
    fileprivate var uploadSessions: Array<CreationUploadSession>
    fileprivate let operationQueue: OperationQueue

    init(requestSender: RequestSender) {
        self.requestSender = requestSender
        self.databaseDAO = DatabaseDAO()
        self.uploadSessions = Array<CreationUploadSession>()
        
        self.operationQueue = OperationQueue()
        self.operationQueue.maxConcurrentOperationCount = 10
        
        setupSessions()
    }
    
    private func updateCurrentStructureVersion() {
        let userDefaults = UserDefaults.standard
        if userDefaults.integer(forKey: CreationUploadService.currentStructureVersionKey) < structureVersion {
            userDefaults.set(structureVersion, forKey: CreationUploadService.currentStructureVersionKey)
            userDefaults.synchronize()
            
            removeAllUploadSessions()
        }
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
        updateCurrentStructureVersion()
        
        // We have to check if there are some new sessions that should consider
        requestSender.cancelAllUploadTasks { [weak self] in
            guard let strongSelf = self else { return }
            var newUploadSessions: [CreationUploadSession] = []
            strongSelf.databaseDAO.fetchAllCreationUploadSessions(strongSelf.requestSender).forEach { (uploadSession) in
                if strongSelf.uploadSessions.filter({ $0.localIdentifier == uploadSession.localIdentifier }).isEmpty {
                    uploadSession.delegate = strongSelf
                    newUploadSessions.append(uploadSession)
                }
            }
            
            strongSelf.uploadSessions.append(contentsOf: newUploadSessions)
            strongSelf.uploadSessions.filter({ !$0.isActive }).forEach { (uploadSession) in
                let operation = CreationUploadSessionOperation(session: uploadSession, completion: completion)
                strongSelf.operationQueue.addOperation(operation)
            }
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

    func uploadCreation(data: NewCreationData, completion: CreationClosure?) -> CreationUploadSessionPublicData? {
        let session = CreationUploadSession(data: data, requestSender: requestSender)
        if let _ = uploadSessions.filter({ $0.localIdentifier == data.localIdentifier }).first {
            let error = APIClientError.duplicatedUploadLocalIdentifierError
            completion?(nil, error)
            delegate?.creationUploadService(self, uploadFailed: session, withError: error)

            return nil
        }

        uploadSessions.append(session)
        databaseDAO.saveCreationUploadSessionToDatabase(session)
        session.delegate = self
        delegate?.creationUploadService(self, newSessionAdded: session)
        
        let operation = CreationUploadSessionOperation(session: session, completion: completion)
        operationQueue.addOperation(operation)
        
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
}
