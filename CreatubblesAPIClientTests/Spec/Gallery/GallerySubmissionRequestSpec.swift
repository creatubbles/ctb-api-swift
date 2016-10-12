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
import Alamofire


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
            
            it("Should return a 422 error after logging in and trying to submit a duplicate creation to the gallery")
            {
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 30)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(GallerySubmissionRequest(galleryId: "b4dcLMAk", creationId: "KnplgMmS"), withResponseHandler: DummyResponseHandler()
                        {
                            (response, error) -> Void in
                            if let error = (error as? AFError)
                            {
                                expect(error.responseCode).to(equal(422))
                            }
                            else
                            {
                                fail("Did not receive an expected AFError")
                            }
                            sender.logout()
                            done()
                        })
                    }
                }
            }
        }
    }
}

