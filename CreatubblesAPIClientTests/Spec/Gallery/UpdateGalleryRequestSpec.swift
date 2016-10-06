//
//  UpdateGalleryRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 20.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class UpdateGalleryRequestSpec: QuickSpec {
    override func spec() {
        
        describe("Update gallery request") {
            
            it("Should have proper method") {
                let data = UpdateGalleryData(galleryId: "12345", name: nil, galleryDescription: nil)
                let request = UpdateGalleryRequest(data: data)
                expect(request.method).to(equal(RequestMethod.put))
            }
            
            it("Should have proper endpoint") {
                let galleryId = "12345"
                let data = UpdateGalleryData(galleryId: galleryId, name: nil, galleryDescription: nil)
                let request = UpdateGalleryRequest(data: data)
                expect(request.endpoint).to(equal("galleries/\(galleryId)"))
            }
            
            it("Should have proper parameters") {
                let galleryId = "12345"
                let title = "sampleTitle"
                let description = "sampleDescription"
                let data = UpdateGalleryData(galleryId: galleryId, name: title, galleryDescription: description)
                let request = UpdateGalleryRequest(data: data)
                expect(request.parameters["name"] as? String).to(equal(title))
                expect(request.parameters["description"] as? String).to(equal(description))
            }
            
            it("Should return correct value after login") {
                let sender = TestComponentsFactory.requestSender
                
                guard let galleryIdentifier = TestConfiguration.testGalleryIdentifier else { return }
                
                waitUntil(timeout: 10) { done in
                    _ = sender.login(TestConfiguration.username, password: TestConfiguration.password)  { (error: Error?) -> Void in
                        expect(error).to(beNil())
                        
                        let data = UpdateGalleryData(galleryId: galleryIdentifier, name: "Sample", galleryDescription: "Sample")
                        let request = UpdateGalleryRequest(data: data)
                        _ = sender.send(request, withResponseHandler: DummyResponseHandler() { (response, error) -> Void in
                                expect(response).to(beNil())
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
