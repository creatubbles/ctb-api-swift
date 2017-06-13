//
//  NewCommentResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2017 Creatubbles Pte. Ltd.
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

class NewCommentResponseHandlerSpec: QuickSpec {
    override func spec() {
        describe("NewComment response handler") {
            it("Should return error when not logged in") {
                let data = NewCommentData(userId: "TestUserId", text: "Test")
                let request = NewCommentRequest(data: data)
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: TestConfiguration.timeoutShort) {
                    done in
                    sender.logout()
                    _ = sender.send(request, withResponseHandler:NewCommentResponseHandler {
                        (error) -> (Void) in
                        expect(error).notTo(beNil())
                        sender.logout()
                        done()
                    })
                }
            }

            it("Should comment gallery when logged in") {
                guard let galleryId = TestConfiguration.testGalleryIdentifier
                    else { return }

                let data = NewCommentData(galleryId: galleryId, text: "TestGalleryComment")
                let request = NewCommentRequest(data: data)
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: TestConfiguration.timeoutShort) {
                    done in
                    _ = sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        _ = sender.send(request, withResponseHandler:NewCommentResponseHandler {
                            (error) -> (Void) in
                            expect(error).to(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }

            it("Should comment profile when logged in") {
                guard let userId = TestConfiguration.testUserIdentifier
                    else { return }

                let data = NewCommentData(userId: userId, text: "TestProfileComment")
                let request = NewCommentRequest(data: data)
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: TestConfiguration.timeoutShort) {
                    done in
                    _ = sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        _ = sender.send(request, withResponseHandler:NewCommentResponseHandler {
                            (error) -> (Void) in
                            expect(error).to(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }

            it("Should comment creation when logged in") {
                guard let creationId = TestConfiguration.testCreationIdentifier
                    else { return }

                let data = NewCommentData(creationId: creationId, text: "TestCreationComment")
                let request = NewCommentRequest(data: data)
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: TestConfiguration.timeoutShort) {
                    done in
                    _ = sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        _ = sender.send(request, withResponseHandler:NewCommentResponseHandler {
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
