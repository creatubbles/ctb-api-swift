//
//  CreationUploadSessionPublicData.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 29.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
public class CreationUploadSessionPublicData: NSObject
{
    public let identifier: String
    public let creationData: NewCreationData
    public let creation: Creation?
    public let error: ErrorType?
    
    init(creationUploadSession: CreationUploadSession)
    {
        identifier = creationUploadSession.localIdentifier
        creation = creationUploadSession.creation
        creationData = creationUploadSession.creationData
        error = creationUploadSession.error
    }
}
