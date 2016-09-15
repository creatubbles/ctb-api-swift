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
                expect(request.method).to(equal(RequestMethod.POST))
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
                
                let availableExtensions = [UploadExtension.PNG, .JPG, .JPEG, .H264, .MPEG4, .WMV, .WEBM, .FLV, .OGG, .OGV, .MP4, .M4V, .MOV]
                for availableExtension in availableExtensions
                {
                    let  request = NewCreationUploadRequest(creationId: "TestId", creationExtension: availableExtension)
                    expect(request.parameters["extension"] as? String).to(equal(availableExtension.rawValue))
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
                        (error: ErrorType?) -> Void in
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

