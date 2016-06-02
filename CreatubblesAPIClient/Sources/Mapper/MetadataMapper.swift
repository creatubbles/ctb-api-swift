//
//  MetadataMapper.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 01.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class MetadataMapper: Mappable
{
    var bubbledCreationIdentifiers: Array<String>?
    var bubbledUserIdentifiers: Array<String>?
    var bubbledGalleryIdentifiers: Array<String>?
    var abilityMappers: Array<AbilityMapper>?
    
    required init?(_ map: Map)
    {
        
    }
    
    func mapping(map: Map)
    {
        bubbledCreationIdentifiers <- map["user_bubbled_creations"]
        bubbledUserIdentifiers <- map["user_bubbled_users"]
        bubbledGalleryIdentifiers <- map["user_bubbled_galleries"]
        
        abilityMappers <- map["abilities"]
    }
}
