//
//  NewCreationUploadRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class NewCreationUploadRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("New creation upload request")
        {
            it("Should have proper method")
            {
                let request = NewCreationUploadRequest(creationId: "TestId")
                expect(request.method).to(equal(RequestMethod.post))
            }
            
            it("Should have proper endpoint")
            {
                let identifier = "TestId"
                let request = NewCreationUploadRequest(creationId: identifier)
                expect(request.endpoint).to(equal("creations/"+identifier+"/uploads"))
            }
            
            it("Should have proper params")
            {
                let defaultRequest = NewCreationUploadRequest(creationId: "TestId")
                expect(defaultRequest.parameters["extension"]).to(beNil())
                
                let availableExtensions = [UploadExtension.png, UploadExtension.jpg, UploadExtension.jpeg, UploadExtension.h264, UploadExtension.mpeg4, UploadExtension.wmv, UploadExtension.webm, UploadExtension.flv, UploadExtension.ogg, UploadExtension.ogv, UploadExtension.mp4, UploadExtension.m4V, UploadExtension.mov]
                for availableExtension in availableExtensions
                {
                    let  request = NewCreationUploadRequest(creationId: "TestId", creationExtension: availableExtension)
                    expect(request.parameters["extension"] as? String).to(equal(availableExtension.stringValue))
                }
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
                        sender.send(NewCreationUploadRequest(creationId: "QMH4I18k"), withResponseHandler: DummyResponseHandler()
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

