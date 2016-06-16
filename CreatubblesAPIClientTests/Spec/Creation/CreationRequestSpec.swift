//
//  CreationRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class CreationRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("Creations request")
        {
            it("Should have a proper method")
            {
                let request = FetchCreationsRequest(page: 1, perPage: 10, galleryId: nil, userId: nil, sort: .Recent, keyword: nil)
                expect(request.method).to(equal(RequestMethod.GET))
            }
            
            it("Should have a proper endpoint")
            {
                let request = FetchCreationsRequest(page: 1, perPage: 10, galleryId: nil, userId: nil, sort: .Recent, keyword: nil)
                expect(request.endpoint).to(equal("creations"))
            }
            
            it("Should have proper endpoint for fetching recommended creations")
            {
                let identifier = "TestIdentifier"
                let creationRequest = FetchCreationsRequest(page: 1, perPage: 0, recommendedCreationId: identifier)
                let userRequest = FetchCreationsRequest(page: 1, perPage: 0, recommendedUserId: identifier)
                
                expect(creationRequest.endpoint).to(equal("creations/\(identifier)/recommended_creations"))
                expect(userRequest.endpoint).to(equal("users/\(identifier)/recommended_creations"))
            }
            
            it("Should return a correct value for creations after login")
            {
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(FetchCreationsRequest(page: 1, perPage: 10, galleryId: nil, userId: nil, sort: .Recent, keyword: nil), withResponseHandler: DummyResponseHandler()
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
            it("Should return a correct value for single creation after login")
            {
                
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                    sender.send(FetchCreationsRequest(creationId: "YNzO8Rmv"), withResponseHandler: DummyResponseHandler()
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
