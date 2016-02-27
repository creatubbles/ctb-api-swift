//
//  CreationUploadService.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 18.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

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
