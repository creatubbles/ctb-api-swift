//
//  PartnerApplicationsRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 03.08.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class PartnerApplicationsRequestSpec: QuickSpec
{
    let id = "test"
    override func spec()
    {
        describe("Partner Applications Request")
        {
            it("Should have proper endpoint")
            {
                let request = PartnerApplicationsRequest(id: self.id)
                expect(request.endpoint).to(equal("partner_applications/test"))
            }
            
            it("Should have proper method")
            {
                let request = PartnerApplicationsRequest(id: self.id)
                expect(request.method).to(equal(RequestMethod.GET))
            }
        }
    }
}
