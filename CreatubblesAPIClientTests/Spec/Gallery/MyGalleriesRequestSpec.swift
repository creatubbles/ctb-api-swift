//
//  MyGalleriesRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek  on 04.09.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class MyGalleriesRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("Galleries request")
        {
            it("Should have proper method")
            {
                let request = MyGalleriesRequest(page: 1, perPage: 20, filter: .None)
                expect(request.method).to(equal(RequestMethod.GET))
            }
            
            it("Should have proper endpoint for list of galleries")
            {
                let request = MyGalleriesRequest(page: 1, perPage: 20, filter: .None)
                expect(request.endpoint).to(equal("users/me/galleries"))
            }
            
            it("Shouldn't have gallery_filter parameter for all galleries")
            {
                let request = MyGalleriesRequest(page: 1, perPage: 20, filter: .None)
                let params = request.parameters
                expect(params["gallery_filter"] as? String).to(beNil())
            }
            
            it("Shouldn have gallery_filter parameter for shared galleries")
            {
                let request = MyGalleriesRequest(page: 1, perPage: 20, filter: .Owned)
                let params = request.parameters
                expect(params["gallery_filter"] as? String).to(equal("only_owned"))
            }
            
            it("Shouldn't have gallery_filter parameter for owned galleries")
            {
                let request = MyGalleriesRequest(page: 1, perPage: 20, filter: .Shared)
                let params = request.parameters
                expect(params["gallery_filter"] as? String).to(equal("only_shared"))
            }
            
            it("Should return correct value for list of all galleries after login")
            {
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(MyGalleriesRequest(page: 1, perPage: 20, filter: .None),
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
            
            it("Should return correct value for list of owned galleries after login")
            {
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(MyGalleriesRequest(page: 1, perPage: 20, filter: .Owned),
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
            
            it("Should return correct value for list of shared galleries after login")
            {
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(MyGalleriesRequest(page: 1, perPage: 20, filter: .Shared),
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