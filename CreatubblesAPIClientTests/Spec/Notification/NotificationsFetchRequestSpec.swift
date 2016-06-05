//
//  NotificationsFetchRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 05.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class NotificationsFetchRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("NotificationsFetchRequest")
        {
            it("Should use GET method")
            {
                let request = NotificationsFetchRequest()
                expect(request.method).to(equal(RequestMethod.GET))
            }
            
            it("Should have 'notifications' endpoint")
            {
                let request = NotificationsFetchRequest()
                expect(request.endpoint).to(equal("notifications"))
            }
            
            it("Shouldn return empty parameters list")
            {
                let request = NotificationsFetchRequest()
                expect(request.parameters).to(beEmpty())
            }
            
        }
    }
}
