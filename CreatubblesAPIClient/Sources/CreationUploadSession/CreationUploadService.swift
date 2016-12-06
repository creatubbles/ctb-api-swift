//
//  CreationUploadService.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2016 Creatubbles Pte. Ltd.
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


protocol CreationUploadServiceDelegate: class
{
    func creationUploadService(_ sender: CreationUploadService, newSessionAdded session: CreationUploadSession)
    func creationUploadService(_ sender: CreationUploadService, uploadFinished session: CreationUploadSession)
    func creationUploadService(_ sender: CreationUploadService, uploadFailed session: CreationUploadSession, withError error: Error)
    func creationUploadService(_ sender: CreationUploadService, progressChanged session: CreationUploadSession, completedUnitCount: Int64, totalUnitcount: Int64, fractionCompleted: Double)
}

class CreationUploadService: CreationUploadSessionDelegate
{
    weak var delegate: CreationUploadServiceDelegate?
    
    fileprivate let databaseDAO: DatabaseDAO
    fileprivate let requestSender: RequestSender
    fileprivate var uploadSessions: Array<CreationUploadSession>
    
    init(requestSender: RequestSender)
    {
        self.requestSender = requestSender
        self.databaseDAO = DatabaseDAO()
        self.uploadSessions = Array<CreationUploadSession>()
        setupSessions()
    }
    
    fileprivate func setupSessions()
    {
        uploadSessions = databaseDAO.fetchAllCreationUploadSessions(requestSender)
        uploadSessions.forEach({ $0.delegate = self })
    }
    
    func getAllActiveUploadSessionsPublicData() -> Array<CreationUploadSessionPublicData>
    {
        return uploadSessions.filter({ $0.isActive == true && $0.state != .cancelled }).map({ CreationUploadSessionPublicData(creationUploadSession: $0) })
    }
    
    func getAllNotFinishedUploadSessionsPublicData() ->  Array<CreationUploadSessionPublicData>
    {
        return uploadSessions.filter({ $0.state.rawValue < CreationUploadSessionState.serverNotified.rawValue })
            .map({ CreationUploadSessionPublicData(creationUploadSession: $0) })
    }
    
    func getAllFinishedUploadSessionPublicData() -> Array<CreationUploadSessionPublicData>
    {
        return uploadSessions.filter({ $0.state == .serverNotified }).map({ CreationUploadSessionPublicData(creationUploadSession: $0) })
    }
    
    func startAllNotFinishedUploadSessions(_ completion: CreationClosure?)
    {
        uploadSessions.forEach({ $0.start(completion) })
    }
    
    func startUploadSession(sessionIdentifier sessionId: String)
    {
        guard let session = uploadSessions.filter( {$0.localIdentifier == sessionId }).first
        else
        {
            Logger.log.warning("Cannot find session with identifier \(sessionId) to start")
            return
        }
        
        session.delegate = self
        session.start(nil)
    }
    
    func removeUploadSession(sessionIdentifier sessionId: String)
    {
        guard let session = uploadSessions.filter( {$0.localIdentifier == sessionId }).first,
              let index = uploadSessions.index(of: session)
        else
        {
            Logger.log.warning("Cannot find session with identifier \(sessionId) to remove")
            return
        }
        
        session.delegate = nil
        session.cancel()
        uploadSessions.remove(at: index)
        databaseDAO.removeUploadSession(withIdentifier: sessionId)
        delegate?.creationUploadService(self, uploadFailed: session, withError: APIClientError.genericUploadCancelledError as Error)
    }
    
    func removeAllUploadSessions()
    {
        uploadSessions.forEach()
        {
            $0.delegate = nil
            $0.cancel()
        }
        databaseDAO.removeAllUploadSessions()
        uploadSessions = databaseDAO.fetchAllCreationUploadSessions(requestSender)
    }
    
    func uploadCreation(data: NewCreationData, completion: CreationClosure?) -> CreationUploadSessionPublicData?
    {
        if let _ = uploadSessions.filter({ $0.localIdentifier == data.localIdentifier }).first {
            completion?(nil, APIClientError.duplicatedUploadLocalIdentifierError)
            
            return nil
        }
        
        let session = CreationUploadSession(data: data, requestSender: requestSender)
        uploadSessions.append(session)
        databaseDAO.saveCreationUploadSessionToDatabase(session)
        session.delegate = self
        session.start(completion)
        delegate?.creationUploadService(self, newSessionAdded: session)
        return CreationUploadSessionPublicData(creationUploadSession: session)
    }
    
    //MARK: - CreationUploadSessionDelegate
    func creationUploadSessionChangedState(_ creationUploadSession: CreationUploadSession)
    {
        databaseDAO.saveCreationUploadSessionToDatabase(creationUploadSession)
        if(creationUploadSession.state == .serverNotified)
        {
            delegate?.creationUploadService(self, uploadFinished: creationUploadSession)
        }
    }
    
    func creationUploadSessionChangedProgress(_ creationUploadSession: CreationUploadSession, completedUnitCount: Int64, totalUnitcount totalUnitCount: Int64, fractionCompleted: Double)
    {
        delegate?.creationUploadService(self, progressChanged: creationUploadSession, completedUnitCount: completedUnitCount, totalUnitcount: totalUnitCount, fractionCompleted: fractionCompleted)
    }
    
    func creationUploadSessionUploadFailed(_ creationUploadSession: CreationUploadSession, error: Error)
    {
        delegate?.creationUploadService(self, uploadFailed: creationUploadSession, withError: error)
    }
}
