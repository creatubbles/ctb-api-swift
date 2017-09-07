//
//  SearchTagMapper.swift
//  CreatubblesAPIClient
//
//  Created by Jakub Jankowski on 07.09.2017.
//  Copyright © 2017 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class SearchTagMapper: Mappable
{
    var identifier: String?
    var translatedNamesMap: Array<NameTranslationObjectMapper>?
    var name: String?
    var imageURL: String?
    
    required init?(map: Map) { /* Intentionally left empty  */ }
    
    func mapping(map: Map)
    {
        identifier <- map["id"]
        translatedNamesMap <- map["attributes.translatedNames"]
        name <- map["attributes.name"]
        imageURL <- map["attributes.imageURL"]
    }
}
