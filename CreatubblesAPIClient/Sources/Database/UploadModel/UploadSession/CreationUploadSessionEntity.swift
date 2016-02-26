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
    var stateRaw = RealmOptional<Int>()
    var isActive = RealmOptional<Bool>()
    dynamic var imageFileName: String?
    dynamic var relativeImageFilePath: String?
    
    dynamic var creationEntity: CreationEntity?
    dynamic var creationUploadEntity: CreationUploadEntity?
    dynamic var creationEntityIdentifier: String?
    
    var state: CreationUploadSessionState
    {
        get
        {
            return CreationUploadSessionState(rawValue: stateRaw.value!)!
        }
    }
    
    override static func primaryKey() -> String?
    {
        return "creationEntityIdentifier"
    }
}

