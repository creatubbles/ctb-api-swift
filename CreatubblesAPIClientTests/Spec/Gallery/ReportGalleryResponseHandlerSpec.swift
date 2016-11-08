//
//  ReportGalleryResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 14.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class ReportGalleryResponseHandlerSpec: QuickSpec {
    
    override func spec()  {
        describe("Report gallery response handler") {
            
            it("Should correctly report a content of the gallery") {
                let sender = TestComponentsFactory.requestSender
                
                guard let galleryIdentifier = TestConfiguration.testGalleryIdentifier else { return }
                
                waitUntil(timeout: 10) { done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(ReportGalleryRequest(galleryId: galleryIdentifier, message: "message"), withResponseHandler: ReportGalleryResponseHandler()
                            {
                                (error) -> Void in
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
