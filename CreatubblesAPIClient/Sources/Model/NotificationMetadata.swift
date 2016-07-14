//
//  NotificationMetadata.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 12.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class NotificationMetadata: NSObject
{
    let totalUnreadCount: Int?
    
    init(mapper: NotificationMetadataMapper)
    {
        totalUnreadCount = mapper.totalUnreadCount ?? 0
    }
}
