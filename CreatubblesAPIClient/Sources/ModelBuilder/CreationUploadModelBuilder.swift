//
//  CreationUploadModelBuilder.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 15.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class CreationUploadModelBuilder: NSObject, Mappable
{

    var identifier: String?
    var uploadUrl: String?
    var contentType: String?
    var pingUrl: String?
    var completedAt: NSDate?
    
    required init?(_ map: Map)
    {
        
    }
    
    func mapping(map: Map)
    {
        identifier  <- map["id"]
        uploadUrl <- map["attributes.url"]
        pingUrl <- map["attributes.ping_url"]
        contentType <- map["attributes.content_type"]
        completedAt <- (map["attributes.completed_at"], DateTransform())
    }
}
