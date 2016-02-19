//
//  CreationUploadSessionEntity.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 18.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Foundation
import RealmSwift

class CreationUploadSessionEntity: Object
{
    dynamic var creationDataEntity: NewCreationDataEntity?
    var stateRaw: Int? = 0
    var isActive: Bool?
    dynamic var imageFileName: String = ""
    dynamic var relativeImageFilePath: String = ""
    
    dynamic var creationEntity: CreationEntity?
    dynamic var creationUploadEntity: CreationUploadEntity?
    
    var state: CreationUploadSessionState
    {
        get
        {
            if let state = CreationUploadSessionState(rawValue: stateRaw!)
            {
                return state
            }
            return CreationUploadSessionState.Initialized
        }
    }
    
    override static func primaryKey() -> String?
    {
        return "creationEntity"
    }
}

