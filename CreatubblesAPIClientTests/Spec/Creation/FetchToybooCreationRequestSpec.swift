//
//  FetchToybooCreationRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 02.11.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class FetchToybooCreationRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("Creations request")
        {
            it("Should have a proper method")
            {
                let request = FetchToybooCreationRequest(creationId: "")
                expect(request.method).to(equal(RequestMethod.get))
            }
            
            it("Should have a proper endpoint")
            {
                let request = FetchToybooCreationRequest(creationId: "test")
                expect(request.endpoint).to(equal("creations/test/toyboo_details"))
            }
        }
    }
}
