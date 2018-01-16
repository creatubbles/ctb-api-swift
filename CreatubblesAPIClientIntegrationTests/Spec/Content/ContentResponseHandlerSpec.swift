//
//  ContentResponseHandlerSpec.swift
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

class ContentResponseHandlerSpec: QuickSpec {
    override func spec() {
        describe("Content response handler") {
            it("Should return recent content after login") {
                let request = ContentRequest(type: .Recent, page: 1, perPage: 20, userId: nil)
                let sender = TestComponentsFactory.requestSender

                waitUntil(timeout: TestConfiguration.timeoutShort) {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:ContentResponseHandler {
                                (responseData) -> (Void) in
                                expect(responseData.error).to(beNil())
                                expect(responseData.objects).notTo(beNil())
                                expect(responseData.pagingInfo).notTo(beNil())
                                sender.logout()
                                done()
                            })
                    }
                }
            }

            it("Should return trending content after login") {
                let request = ContentRequest(type: .Trending, page: 1, perPage: 20, userId: nil)
                let sender = TestComponentsFactory.requestSender

                waitUntil(timeout: TestConfiguration.timeoutShort) {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:ContentResponseHandler {
                            (responseData) -> (Void) in
                            expect(responseData.error).to(beNil())
                            expect(responseData.objects).notTo(beNil())
                            expect(responseData.pagingInfo).notTo(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }

            it("Should return Connected contents after login") {
                let request = ContentRequest(type: .Connected, page: 1, perPage: 20, userId: nil)
                let sender = TestComponentsFactory.requestSender

                waitUntil(timeout: TestConfiguration.timeoutMedium) {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:ContentResponseHandler {
                            (responseData) -> (Void) in
                            expect(responseData.error).to(beNil())
                            expect(responseData.objects).notTo(beNil())
                            expect(responseData.pagingInfo).notTo(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }

        }
        it("Should return User Bubbled Contents after login") {
            let request = ContentRequest(type: .BubbledContents, page: 1, perPage: 20, userId: TestConfiguration.testUserIdentifier)
            let sender = TestComponentsFactory.requestSender

            waitUntil(timeout: TestConfiguration.timeoutMedium) {
                done in
                sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                    (error: Error?) -> Void in
                    expect(error).to(beNil())
                    sender.send(request, withResponseHandler: ContentResponseHandler {
                        (responseData) -> (Void) in
                        expect(responseData.error).to(beNil())
                        expect(responseData.objects).notTo(beNil())
                        expect(responseData.pagingInfo).notTo(beNil())
                        sender.logout()
                        done()
                    })
                }
            }
        }
        it("Should return Contents By A User after login") {
            let request = ContentRequest(type: .ContentsByAUser, page: 1, perPage: 20, userId: TestConfiguration.testUserIdentifier)
            let sender = TestComponentsFactory.requestSender

            waitUntil(timeout: TestConfiguration.timeoutMedium) {
                done in
                sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                    (error: Error?) -> Void in
                    expect(error).to(beNil())
                    sender.send(request, withResponseHandler: ContentResponseHandler {
                        (responseData) -> (Void) in
                        expect(responseData.error).to(beNil())
                        expect(responseData.objects).notTo(beNil())
                        expect(responseData.pagingInfo).notTo(beNil())
                        sender.logout()
                        done()
                    })
                }
            }
        }
        it("Should return Contents based on Followed Users after login") {
            let request = ContentRequest(type: .Followed, page: 1, perPage: 20, userId: nil)
            let sender = TestComponentsFactory.requestSender

            waitUntil(timeout: TestConfiguration.timeoutMedium) {
                done in
                sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                    (error: Error?) -> Void in
                    expect(error).to(beNil())
                    sender.send(request, withResponseHandler: ContentResponseHandler {
                        (responseData) -> (Void) in
                        expect(responseData.error).to(beNil())
                        expect(responseData.objects).notTo(beNil())
                        expect(responseData.pagingInfo).notTo(beNil())
                        sender.logout()
                        done()
                    })
                }
            }
        }
        
        it("Should return trending creations") {
            let request = FetchTrendingCreationsRequest()
            let sender = TestComponentsFactory.requestSender
            
            waitUntil(timeout: TestConfiguration.timeoutShort) {
                done in
                sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                    (error: Error?) -> Void in
                    expect(error).to(beNil())
                    sender.send(request, withResponseHandler:ContentResponseHandler {
                        (responseData) -> (Void) in
                        expect(responseData.error).to(beNil())
                        expect(responseData.objects).notTo(beNil())
                        sender.logout()
                        done()
                    })
                }
            }
        }
        
        it("Should return trending users") {
            let request = FetchTrendingUsersRequest()
            let sender = TestComponentsFactory.requestSender
            
            waitUntil(timeout: TestConfiguration.timeoutShort) {
                done in
                sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                    (error: Error?) -> Void in
                    expect(error).to(beNil())
                    sender.send(request, withResponseHandler:ContentResponseHandler {
                        (responseData) -> (Void) in
                        expect(responseData.error).to(beNil())
                        expect(responseData.objects).notTo(beNil())
                        sender.logout()
                        done()
                    })
                }
            }
        }
    }
}
