//
//  GallerySubmissionRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class GallerySubmissionRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("Gallery Submission request")
        {
            it("Should have proper method")
            {
                let request = GallerySubmissionRequest(galleryId: "12345", creationId: "12345")
                expect(request.method).to(equal(RequestMethod.post))
            }
            
            it("Should have proper endpoint")
            {
                let request = GallerySubmissionRequest(galleryId: "12345", creationId: "12345")
                expect(request.endpoint).to(equal("gallery_submissions"))
            }
            
            it("Should have proper parameters")
            {
                let creationId = "TestCreationId"
                let galleryId = "TestGalleryId"
                let request = GallerySubmissionRequest(galleryId: galleryId, creationId: creationId)
                expect(request.parameters["gallery_id"] as? String).to(equal(galleryId))
                expect(request.parameters["creation_id"] as? String).to(equal(creationId))
            }
            
            it("Should return correct value after login")
            {
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(GallerySubmissionRequest(galleryId: "x3pUEOeZ", creationId: "OvM8Xmqj"), withResponseHandler: DummyResponseHandler()
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

