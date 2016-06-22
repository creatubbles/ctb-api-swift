//
//  GalleriesRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class GalleriesRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("Galleries request")
        {
            it("Should have proper method")
            {
                let request = GalleriesRequest(galleryId: "TestGalleryId")
                expect(request.method).to(equal(RequestMethod.GET))
            }
            
            it("Should have proper endpoint for specified gallery")
            {
                let id = "TestGalleryId"
                let request = GalleriesRequest(galleryId: id)
                expect(request.endpoint).to(equal("galleries/"+id))
            }
            
            it("Should have proper endpoint for list of galleries")
            {
                let request = GalleriesRequest(page: 1, perPage: 20, sort: .Recent, userId: nil)
                expect(request.endpoint).to(equal("galleries"))
            }
            
            it("Should have proper endpoint for list of creation galleries")
            {
                let id = "TestCreationId"
                let request = GalleriesRequest(creationId: id, page: 1, perPage: 20, sort: .Recent)
                expect(request.endpoint).to(equal("creations/\(id)/galleries"))
            }
            
            it("Should have proper endpoint for list of user galleries")
            {
                let userId = "TestUserId"
                let request = GalleriesRequest(page: 1, perPage: 20, sort: .Recent, userId: userId)
                expect(request.endpoint).to(equal("users/\(userId)/galleries"))
            }
            
            it("Should return correct value for single gallery after login")
            {
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(GalleriesRequest(galleryId: "NrLLiMVC"), withResponseHandler: DummyResponseHandler()
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
            
            it("Should return correct value for list of galleries after login")
            {
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(GalleriesRequest(page: 1, perPage: 20, sort: .Recent, userId: nil),
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

