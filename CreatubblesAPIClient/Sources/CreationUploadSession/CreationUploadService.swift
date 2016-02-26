//
//  CreationUploadService.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 18.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
protocol CreationUploadServiceDelegate
{
    optional func creationUploadSessionUploadFinished(creationUploadService: CreationUploadSession)
}

class CreationUploadService: CreationUploadSessionDelegate
{
    weak var delegate: CreationUploadServiceDelegate?
    let databaseDAO: DatabaseDAO
    //let apiClient: CreatubblesAPIClient?
    
    let requestSender: RequestSender
    
    init(requestSender: RequestSender)
    {
        //self.apiClient = CreatubblesAPIClient(settings: requestSender.settings)
        self.requestSender = requestSender
        self.databaseDAO = DatabaseDAO()
        //self.delegate = apiClient
    }
    
    func uploadCreation(data: NewCreationData, completion: CreationClousure?)
    {
        let session = CreationUploadSession(data: data, requestSender: requestSender)
        session.start(completion)
    }
    
    @objc func creationUploadSessionChangedState(creationUploadSession: CreationUploadSession)
    {
        databaseDAO.saveCreationUploadSessionToDatabase(creationUploadSession)
        if(creationUploadSession.state.rawValue > 4)
        {
            delegate?.creationUploadSessionUploadFinished?(creationUploadSession)
        }
    }
}
