//
//  NotificationReadRequest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 07.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class NotificationReadRequest: Request
{
    override var method: RequestMethod { return .post }
    override var endpoint: String { return "notifications/\(notificationIdentifier)/read" }
    override var parameters: Dictionary<String, AnyObject> { return Dictionary<String, AnyObject>() }
    
    fileprivate let notificationIdentifier: String
    
    init(notificationIdentifier: String)
    {
        self.notificationIdentifier = notificationIdentifier
    }
    
}
