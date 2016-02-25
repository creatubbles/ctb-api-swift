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
    optional func creationUploadSessionChangedState(creationUploadService: CreationUploadSession)
}

class CreationUploadService: CreationUploadSessionDelegate
{
    weak var delegate: CreationUploadServiceDelegate?
    
    let requestSender: RequestSender
    
    init(requestSender: RequestSender)
    {
        self.requestSender = requestSender
    }
    
    func uploadCreation(data: NewCreationData, completion: CreationClousure?)
    {
        let session = CreationUploadSession(data: data, requestSender: requestSender)
        session.start(completion)
    }
    
    @objc func creationUploadSessionChangedState(creationUploadSession: CreationUploadSession)
    {
        creationUploadSession.delegate = self
        delegate?.creationUploadSessionChangedState?(creationUploadSession)
    }
}
