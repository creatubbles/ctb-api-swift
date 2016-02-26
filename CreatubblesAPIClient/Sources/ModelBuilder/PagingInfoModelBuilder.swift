//
//  PagingInfoModelBuilder.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 26.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class PagingInfoModelBuilder: Mappable
{
    var totalPages: Int?
    var totalCount: Int?
    
    required init?(_ map: Map)
    {
        
    }
    
    func mapping(map: Map)
    {
        totalPages <- map["total_pages"]
        totalCount <- map["total_count"]        
    }
}
