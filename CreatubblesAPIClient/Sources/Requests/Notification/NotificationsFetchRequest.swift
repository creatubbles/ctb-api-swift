//
//  NotificationsFetchRequest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 05.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class NotificationsFetchRequest: Request
{
    override var method: RequestMethod  { return .GET }
    override var endpoint: String       { return "notifications" }
    override var parameters: Dictionary<String, AnyObject> { return Dictionary<String, AnyObject>() }
}
