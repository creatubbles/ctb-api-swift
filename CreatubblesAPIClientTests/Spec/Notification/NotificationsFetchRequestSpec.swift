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
            
            it("Should return empty parameters list when not pagable")
            {
                let request = NotificationsFetchRequest()
                expect(request.parameters).to(beEmpty())
            }
            
            it("Should be pageable")
            {
                let request = NotificationsFetchRequest(page: 1, perPage: 10)
                expect(request.parameters["page"] as? Int).to(equal(1))
                expect(request.parameters["per_page"] as? Int).to(equal(10))
            }
            
        }
    }
}
