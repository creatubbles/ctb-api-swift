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
    func creationUploadSessionUploadFinished(creationUploadService: CreationUploadSession)
    func creationUploadSessionProgressChanged(creationUploadSession: CreationUploadSession, bytesWritten: Int, totalBytesWritten: Int, totalBytesExpectedToWrite: Int)
}

class CreationUploadService: CreationUploadSessionDelegate
{
    weak var delegate: CreationUploadServiceDelegate?
    let databaseDAO: DatabaseDAO
    
    let requestSender: RequestSender
    
    init(requestSender: RequestSender)
    {
        self.requestSender = requestSender
        self.databaseDAO = DatabaseDAO()
    }
    
    func uploadCreation(data: NewCreationData, completion: CreationClousure?)
    {
        let session = CreationUploadSession(data: data, requestSender: requestSender)
        session.delegate = self
        session.start(completion)
    }
    
    func creationUploadSessionChangedState(creationUploadSession: CreationUploadSession)
    {
        databaseDAO.saveCreationUploadSessionToDatabase(creationUploadSession)
        if(creationUploadSession.state == .ServerNotified)
        {
            delegate?.creationUploadSessionUploadFinished(creationUploadSession)
        }
    }
    
    func creationUploadSessionChangedProgress(creationUploadSession: CreationUploadSession, bytesWritten: Int, totalBytesWritten: Int, totalBytesExpectedToWrite: Int)
    {
        delegate?.creationUploadSessionProgressChanged(creationUploadSession, bytesWritten: bytesWritten, totalBytesWritten: totalBytesWritten, totalBytesExpectedToWrite: totalBytesExpectedToWrite)
    }
}
