//
//  NewGalleryRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class NewGalleryRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("New Gallery request")
        {
            let timestamp = String(Int(round(NSDate().timeIntervalSince1970 .truncatingRemainder(dividingBy: 1000))))
            let name = "MMGallery"+timestamp
            let galleryDescription = "MMGallery"+timestamp
            let openForAll = false
            let ownerId = "dSPX04ab"
            let request = NewGalleryRequest(name: name, galleryDescription: galleryDescription, openForAll: openForAll, ownerId: ownerId)
            
            it("Should have proper method")
            {
                expect(request.method).to(equal(RequestMethod.post))
            }
            
            it("Should have proper endpoint")
            {
                expect(request.endpoint).to(equal("galleries"))
            }
            
            it("Should have proper parameters set")
            {
                let params = request.parameters
                expect(params["name"] as? String).to(equal(name))
                expect(params["description"] as? String).to(equal(galleryDescription))
                expect(params["open_for_all"] as? Bool).to(equal(openForAll))
                expect(params["owner_id"] as? String).to(equal(ownerId))
            }
            
            it("Should return correct value after login")
            {
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 20)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler: DummyResponseHandler()
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

