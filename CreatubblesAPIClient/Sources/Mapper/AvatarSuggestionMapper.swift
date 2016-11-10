//
//  AvatarSuggestionMapper.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 10.11.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class AvatarSuggestionMapper: Mappable
{
    var id: String?
    var avatarURL: String?
    
    required init?(map: Map) { /* Intentionally left empty  */ }
    
    func mapping(map: Map)
    {
        id <-  map["id"]
        avatarURL <- map["attributes.url"]
    }
}
