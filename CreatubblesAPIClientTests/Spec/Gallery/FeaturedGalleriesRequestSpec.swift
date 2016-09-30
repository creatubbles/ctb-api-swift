//
//  FeaturedGalleriesRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 06.09.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class FeaturedGalleriesRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("Galleries request")
        {
            it("Should have proper method")
            {
                let request = FeaturedGalleriesRequest(page: 1, perPage: 20)
                expect(request.method).to(equal(RequestMethod.GET))
            }
            
            it("Should have proper endpoint for list of galleries")
            {
                let request = FeaturedGalleriesRequest(page: 1, perPage: 20)
                expect(request.endpoint).to(equal("featured_galleries"))
            }
            
            it("Should return correct value for list of featured galleries after login")
            {
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(FeaturedGalleriesRequest(page: 1, perPage: 20),
                                    withResponseHandler: DummyResponseHandler()
                                        {
                                            (response, error) -> Void in
                                            expect(response).notTo(beNil())
                                            expect(error).to(beNil())
                                            sender.logout()
                                            done()
                            })
                    }
                }
            }
        }
    }
}