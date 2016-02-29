//
//  ErrorMapper.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 27.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class ErrorMapper: Mappable
{
    var title: String?
    var detail: String?
    
    required init?(_ map: Map)
    {
        
    }
    
    func mapping(map: Map)
    {
        title <- map["title"]
        detail <- map["detail"]
    }
}
