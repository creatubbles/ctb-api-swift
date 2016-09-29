//
//  CreationUploadSessionPublicData.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 29.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
open class CreationUploadSessionPublicData: NSObject
{
    open let identifier: String
    open let creationData: NewCreationData
    open let creation: Creation?
    open let error: Error?
    
    init(creationUploadSession: CreationUploadSession)
    {
        identifier = creationUploadSession.localIdentifier
        creation = creationUploadSession.creation
        creationData = creationUploadSession.creationData
        error = creationUploadSession.error
    }
}
