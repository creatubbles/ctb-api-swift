//
//  CreationUploadService.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 18.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class CreationUploadService
{
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
}
