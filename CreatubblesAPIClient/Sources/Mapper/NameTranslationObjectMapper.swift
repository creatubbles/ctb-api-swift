//
//  NameTranslationObjectMapper.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 29.08.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class NameTranslationObjectMapper: Mappable
{
    var code: String?
    var name: String?
    var original: Bool?
    
    //MARK: - Mappable
    required init?(_ map: Map) { /* Intentionally left empty  */ }
    
    func mapping(_ map: Map)
    {
        code <- map["code"]
        name <- map["name"]
        original <- map["original"]
    }
    
    func isValid() -> Bool
    {
        return code != nil && name != nil && original != nil
    }
}
