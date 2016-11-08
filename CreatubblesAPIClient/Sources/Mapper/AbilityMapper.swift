//
//  AbilityMapper.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 01.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class AbilityMapper: Mappable
{
    var identifier: String?
    var type: String?
    var resourceType: String?
    var resourceIdentifier: String?
    var operation: String?
    var permission: Bool?    
    
    required init?(map: Map) { /* Intentionally left empty  */ }
    
    func mapping(map: Map)
    {
        identifier  <- map["id"]
        type <- map["type"]
        
        resourceType <- map["attributes.resource_type"]
        resourceIdentifier <- map["attributes.resource_id"]
        operation <- map["attributes.operation"]
        permission <- map["attributes.permission"]
    }
}
