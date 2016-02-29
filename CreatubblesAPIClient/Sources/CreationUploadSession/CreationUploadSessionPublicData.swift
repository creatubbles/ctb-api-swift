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
    let creation: Creation?
    let creationData: NewCreationData
    
    init(creationUploadSession: CreationUploadSession)
    {
        creation = creationUploadSession.creation
        creationData = creationUploadSession.creationData
    }
}
