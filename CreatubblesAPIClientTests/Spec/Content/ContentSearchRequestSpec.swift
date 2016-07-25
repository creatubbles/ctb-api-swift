//
//  ContentSearchRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 25.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class ContentSearchRequestSpec: QuickSpec
{
    override func spec()
    {

        describe("Fetch content search request")
        {
            it("Should have a proper method")
            {
                let request = ContentSearchRequest(query: "hanaG", page: 1, perPage: 20)
                expect(request.method).to(equal(RequestMethod.GET))
            }
            
            it("Should have a proper endpoint")
            {
                let request = ContentSearchRequest(query: "hanaG", page: 1, perPage: 20)
                expect(request.endpoint).to(equal("contents"))
            }
        }
    }
}
