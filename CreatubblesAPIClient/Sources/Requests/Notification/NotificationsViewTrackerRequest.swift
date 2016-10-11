//
//  NotificationsViewTrackerRequest.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 11.10.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class NotificationsViewTrackerRequest: Request
{
    override var method: RequestMethod { return .PUT }
    override var endpoint: String { return "notifications/view_tracker" }
}
