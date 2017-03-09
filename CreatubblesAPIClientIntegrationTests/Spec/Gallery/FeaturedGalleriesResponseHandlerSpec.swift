//
//  FeaturedGalleriesResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 09.03.2017.
//  Copyright © 2017 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class FeaturedGalleriesResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("Featured galleries response handler")
        {
            it("Should return correct values after login")
            {
                let request = FeaturedGalleriesRequest(page: 1, perPage: 10)
                let sender =  TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    _ = sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        _ = sender.send(request, withResponseHandler:GalleriesResponseHandler()
                        {
                            (galleries: Array<Gallery>?,pageInfo: PagingInfo?, error: Error?) -> Void in
                            expect(galleries).notTo(beNil())
                            expect(error).to(beNil())
                            expect(pageInfo).notTo(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
            
            it("Should return correct values when not logged in")
            {
                let request = FeaturedGalleriesRequest(page: 1, perPage: 10)
                let sender =  TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    _ = sender.logout()
                    _ = sender.send(request, withResponseHandler:GalleriesResponseHandler()
                    {
                        (galleries: Array<Gallery>?,pageInfo: PagingInfo?, error: Error?) -> Void in
                        expect(galleries).notTo(beNil())
                        expect(error).to(beNil())
                        expect(pageInfo).notTo(beNil())
                        done()
                    })
                }
            }
        }
    }
}
