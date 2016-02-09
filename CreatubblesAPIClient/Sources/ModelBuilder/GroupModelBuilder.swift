//
//  GroupModelBuilder.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 09.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class GroupModelBuilder: NSObject, Mappable
{
    var identifier: String?
    var name: String?
    var taggingsCount: Int?
    
    required init?(_ map: Map)
    {
        
    }
    
    func mapping(map: Map)
    {
        identifier  <- map["id"]
        name <- map["name"]
        taggingsCount <- map["taggings_count"]
    }
}
