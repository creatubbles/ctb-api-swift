//
//  NotificationMetadataMapper.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 12.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class NotificationMetadataMapper: Mappable
{
    var totalUnreadCount: Int?
    
    required init?(map: Map) { /* Intentionally left empty  */ }
    
    func mapping(map: Map)
    {
        totalUnreadCount <- map["total_unread_count"]
    }
}
