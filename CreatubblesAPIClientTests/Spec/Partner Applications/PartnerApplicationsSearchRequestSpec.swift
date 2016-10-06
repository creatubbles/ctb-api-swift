//
//  PartnerApplicationsSearchRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 04.08.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class PartnerApplicationsSearchRequestSpec: QuickSpec
{
    let query = "example-app"
    override func spec()
    {
        describe("Partner Applications Search Request")
        {
            it("Should have proper endpoint")
            {
                let request = PartnerApplicationsSearchRequest(query: self.query)
                expect(request.endpoint).to(equal("partner_applications"))
            }
            
            it("Should have proper method")
            {
                let request = PartnerApplicationsSearchRequest(query: self.query)
                expect(request.method).to(equal(RequestMethod.get))
            }
        }
    }
}
