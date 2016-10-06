//
//  FavoriteGalleriesRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 06.09.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class FavoriteGalleriesRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("Galleries request")
        {
            it("Should have proper method")
            {
                let request = FavoriteGalleriesRequest(page: 1, perPage: 20)
                expect(request.method).to(equal(RequestMethod.get))
            }
            
            it("Should have proper endpoint for list of galleries")
            {
                let request = FavoriteGalleriesRequest(page: 1, perPage: 20)
                expect(request.endpoint).to(equal("users/me/favorite_galleries"))
            }
            
            it("Should return correct value for list of favorite galleries after login")
            {
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(FavoriteGalleriesRequest(page: 1, perPage: 20),
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
