//
//  NewCreationUploadResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class NewCreationUploadResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("New Creation Upload response handler")
        {
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
                        sender.send(NewCreationUploadRequest(creationId: "TestCreation"), withResponseHandler:NewCreationUploadResponseHandler()
                            {
                                (creationUpload: CreationUpload?, error:ErrorType?) -> Void in
                                expect(error).to(beNil())
                                expect(creationUpload).notTo(beNil())
                                done()
                            })
                    }
                }
            }
            
            it("Should return error when not logged in")
            {
                let sender = TestComponentsFactory.requestSender
                sender.logout()
                waitUntil(timeout: 10)
                {
                    done in
                    sender.send(NewCreationUploadRequest(creationId: "TestCreation"), withResponseHandler:NewCreationUploadResponseHandler()
                        {
                            (creationUpload: CreationUpload?, error:ErrorType?) -> Void in
                            expect(error).notTo(beNil())
                            expect(creationUpload).to(beNil())
                            done()
                        })
                }
            }
        }
        
    }
}

