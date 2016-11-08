//
//  NotificationReadRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 07.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class NotificationReadRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("NotificationReadRequest")
        {            
            it("Should use POST method")
            {
                let request = NotificationReadRequest(notificationIdentifier: "")
                expect(request.method).to(equal(RequestMethod.post))
            }
            
            it("Should have 'notifications/IDENTIFIER/read' endpoint")
            {
                let identifier = "TestIdentifier"
                let request = NotificationReadRequest(notificationIdentifier: identifier)
                expect(request.endpoint).to(equal("notifications/\(identifier)/read"))
            }
            
            it("Should return empty parameters list")
            {
                let request = NotificationReadRequest(notificationIdentifier: "")
                expect(request.parameters).to(beEmpty())
            }
        }
    }
}
