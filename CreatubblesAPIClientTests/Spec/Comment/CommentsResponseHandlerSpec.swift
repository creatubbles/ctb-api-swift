//
//  CommentsResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class CommentsResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("Comment response handler")
        {
            it("Should return comments for Creation")
            {
                guard let creationId = TestConfiguration.testCreationIdentifier
                    else { return }
                
                let request = CommentsRequest(creationId: creationId, page: nil, perPage: nil)
                let sender = RequestSender(settings: TestConfiguration.settings)
                
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:CommentsResponseHandler()
                            {
                                (comments, pageInfo, error) -> (Void) in
                                expect(error).to(beNil())
                                expect(comments).notTo(beNil())
                                expect(pageInfo).notTo(beNil())
                                sender.logout()
                                done()
                            })
                    }
                }
            }
            
            it("Should return comments for Gallery")
            {
                guard let galleryId = TestConfiguration.testGalleryIdentifier
                    else { return }
                
                let request = CommentsRequest(galleryId: galleryId, page: nil, perPage: nil)
                //                let sender = TestComponentsFactory.requestSender
                let sender = RequestSender(settings: TestConfiguration.settings)
                
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:CommentsResponseHandler()
                            {
                                (comments, pageInfo, error) -> (Void) in
                                expect(error).to(beNil())
                                expect(comments).notTo(beNil())
                                expect(pageInfo).notTo(beNil())
                                sender.logout()
                                done()
                            })
                    }
                }
            }
            
            it("Should return comments for Profile")
            {
                guard let userId = TestConfiguration.testUserIdentifier
                    else { return }
                
                let request = CommentsRequest(userId: userId, page: nil, perPage: nil)
                //                let sender = TestComponentsFactory.requestSender
                let sender = RequestSender(settings: TestConfiguration.settings)
                
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:CommentsResponseHandler()
                            {
                                (comments, pData, error) -> (Void) in
                                expect(error).to(beNil())
                                expect(comments).notTo(beNil())
                                expect(pData).notTo(beNil())
                                sender.logout()
                                done()
                            })
                    }
                }
            }
        }
    }
}
