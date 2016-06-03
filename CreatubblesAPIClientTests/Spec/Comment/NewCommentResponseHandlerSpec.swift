//
//  NewCommentResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class NewCommentResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("NewComment response handler")
        {
            it("Should return error when not logged in")
            {
                let data = NewCommentData(userId: "TestUserId", text: "Test")
                let request = NewCommentRequest(data: data)
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.logout()
                    sender.send(request, withResponseHandler:NewCommentResponseHandler()
                    {
                        (error) -> (Void) in
                        expect(error).notTo(beNil())
                        sender.logout()
                        done()
                    })
                }
            }
            
            it("Should comment gallery when logged in")
            {
                guard let galleryId = TestConfiguration.testGalleryIdentifier
                    else { return }
                
                let data = NewCommentData(galleryId: galleryId, text: "TestGalleryComment")
                let request = NewCommentRequest(data: data)
                //                let sender = TestComponentsFactory.requestSender
                let sender = RequestSender(settings: TestConfiguration.settings)
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:NewCommentResponseHandler()
                        {
                            (error) -> (Void) in
                            expect(error).to(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
            
            it("Should comment profile when logged in")
            {
                guard let userId = TestConfiguration.testUserIdentifier
                    else { return }
                
                let data = NewCommentData(userId: userId, text: "TestProfileComment")
                let request = NewCommentRequest(data: data)
                //                let sender = TestComponentsFactory.requestSender
                let sender = RequestSender(settings: TestConfiguration.settings)
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:NewCommentResponseHandler()
                        {
                            (error) -> (Void) in
                            expect(error).to(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
            
            it("Should comment creation when logged in")
            {
                guard let creationId = TestConfiguration.testCreationIdentifier
                    else { return }
                
                let data = NewCommentData(creationId: creationId, text: "TestCreationComment")
                let request = NewCommentRequest(data: data)
                //                let sender = TestComponentsFactory.requestSender
                let sender = RequestSender(settings: TestConfiguration.settings)
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:NewCommentResponseHandler()
                            {
                                (error) -> (Void) in
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
