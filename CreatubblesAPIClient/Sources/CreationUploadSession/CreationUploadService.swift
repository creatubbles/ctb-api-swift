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
    func creationUploadService(sender: CreationUploadService, newSessionAdded session: CreationUploadSession)
    func creationUploadService(sender: CreationUploadService, uploadFinished session: CreationUploadSession)
    func creationUploadService(sender: CreationUploadService, uploadFailed session: CreationUploadSession, withError error: ErrorType)
    func creationUploadService(sender: CreationUploadService, progressChanged session: CreationUploadSession, bytesWritten: Int, totalBytesWritten: Int, totalBytesExpectedToWrite: Int)
}

class CreationUploadService: CreationUploadSessionDelegate
{
    weak var delegate: CreationUploadServiceDelegate?
    
    private let databaseDAO: DatabaseDAO
    private let requestSender: RequestSender
    private var uploadSessions: Array<CreationUploadSession>
    
    init(requestSender: RequestSender)
    {
        self.requestSender = requestSender
        self.databaseDAO = DatabaseDAO()
        self.uploadSessions = Array<CreationUploadSession>()
        setupSessions()
    }
    
    private func setupSessions()
    {
        uploadSessions = databaseDAO.fetchAllCreationUploadSessions(requestSender)
        uploadSessions.forEach({ $0.delegate = self })
    }
    
    func getAllActiveUploadSessionsPublicData() -> Array<CreationUploadSessionPublicData>
    {
        return uploadSessions.filter({ $0.isActive == true }).map({ CreationUploadSessionPublicData(creationUploadSession: $0) })
    }
    
    func getAllFinishedUploadSessionPublicData() -> Array<CreationUploadSessionPublicData>
    {
        return uploadSessions.filter({ $0.state == .ServerNotified }).map({ CreationUploadSessionPublicData(creationUploadSession: $0) })
    }
    
    func startAllNotFinishedUploadSessions(completion: CreationClosure?)
    {
        uploadSessions.forEach({ $0.start(completion) })                
    }
    
    func removeUploadSession(sessionId: String)
    {
        if  let session = uploadSessions.filter( {$0.localIdentifier == sessionId }).first,
            let index = uploadSessions.indexOf(session)
        {
            session.delegate = nil
            uploadSessions.removeAtIndex(index)
            databaseDAO.removeUploadSession(withIdentifier: sessionId)
        }
    }
    
    func removeAllUploadSessions()
    {
        uploadSessions.forEach({ $0.delegate = self })
        databaseDAO.removeAllUploadSessions()
        uploadSessions = databaseDAO.fetchAllActiveUploadSessions(requestSender)
    }
    
    func uploadCreation(data: NewCreationData, completion: CreationClosure?) -> CreationUploadSessionPublicData
    {
        let session = CreationUploadSession(data: data, requestSender: requestSender)
        uploadSessions.append(session)
        databaseDAO.saveCreationUploadSessionToDatabase(session)
        session.delegate = self
        session.start(completion)
        delegate?.creationUploadService(self, newSessionAdded: session)
        return CreationUploadSessionPublicData(creationUploadSession: session)        
    }
    
    
    //MARK: - CreationUploadSessionDelegate
    func creationUploadSessionChangedState(creationUploadSession: CreationUploadSession)
    {
        databaseDAO.saveCreationUploadSessionToDatabase(creationUploadSession)
        if(creationUploadSession.state == .ServerNotified)
        {
            delegate?.creationUploadService(self, uploadFinished: creationUploadSession)
        }
    }
    
    func creationUploadSessionChangedProgress(creationUploadSession: CreationUploadSession, bytesWritten: Int, totalBytesWritten: Int, totalBytesExpectedToWrite: Int)
    {
        delegate?.creationUploadService(self, progressChanged: creationUploadSession, bytesWritten: bytesWritten, totalBytesWritten: totalBytesWritten, totalBytesExpectedToWrite: totalBytesExpectedToWrite)
    }
    
    func creationUploadSessionUploadFailed(creationUploadSession: CreationUploadSession, error: ErrorType)
    {
        delegate?.creationUploadService(self, uploadFailed: creationUploadSession, withError: error)
    }
}
