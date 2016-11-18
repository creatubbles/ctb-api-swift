//
//  GallerySubmissionRequestSpec.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2016 Creatubbles Pte. Ltd.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
                            if let error = error
                            {
                                expect(error).toNot(beNil())
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

