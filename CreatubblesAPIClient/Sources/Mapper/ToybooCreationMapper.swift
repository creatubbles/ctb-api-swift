//
//  ToybooCreationMapper.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 02.11.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class ToybooCreationMapper: Mappable
{
    var identifier: String?
    var uzpbUrl: String?
    var contentUrl: String?
    
    //MARK: - Mappable
    required init?(map: Map) { /* Intentionally left empty  */ }
    
    func mapping(map: Map)
    {
        identifier <- map["id"]
        uzpbUrl <- map["attributes.uzpb_url"]
        contentUrl <- map["attributes.content_url"]
    }
}
