//
//  ContentRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class ContentRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("Fetch content request")
        {
            it("Should have a proper method")
            {
                let request = ContentRequest(type: .Recent, page: nil, perPage: nil, userId: nil)
                expect(request.method).to(equal(RequestMethod.GET))
            }
            
            it("Should have a proper endpoint when fetching Recent content")
            {
                let request = ContentRequest(type: .Recent, page: nil, perPage: nil, userId: nil)
                expect(request.endpoint).to(equal("contents/recent"))
            }
            
            it("Should have a proper endpoint when fetching Trending content")
            {
                let request = ContentRequest(type: .Trending, page: nil, perPage: nil, userId: nil)
                expect(request.endpoint).to(equal("contents/trending"))
            }
            it("Should have a proper endpoint when fetching User Bubbled contents")
            {
                let testId = "testId"
                let request = ContentRequest(type: .BubbledContents, page: nil, perPage: nil, userId: testId)
                expect(request.endpoint).to(equal("users/testId/bubbled_contents"))
            }
            it("Should have a proper endpoint when fetching User Connected contents")
            {
                let request = ContentRequest(type: .Connected, page: nil, perPage: nil)
                expect(request.endpoint).to(equal("contents/connected"))
            }
        }
    }
}
