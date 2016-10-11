//
//  NotificationsViewTrackerRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 11.10.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class NotificationsViewTrackerRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("Notifications View Tracker Request")
        {
            it("Should use PUT method")
            {
                let request = NotificationsViewTrackerRequest()
                expect(request.method).to(equal(RequestMethod.PUT))
            }
            
            it("Should have 'notifications/view_tracker' endpoint")
            {
                let request = NotificationsViewTrackerRequest()
                
                expect(request.endpoint).to(equal("notifications/view_tracker"))
            }
        }
    }
}
