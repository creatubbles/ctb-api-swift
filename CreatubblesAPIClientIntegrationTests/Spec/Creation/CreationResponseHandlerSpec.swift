//
//  CreationResponseHandlerSpec.swift
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

import Foundation

import Quick
import Nimble
@testable import CreatubblesAPIClient

class CreationResponseHandlerSpec: QuickSpec {
    override func spec() {
        describe("Fetch Creations response handler") {
            it("Should return correct value for creations after login") {
                let request = FetchCreationsRequest(page: 1, perPage: 10, galleryId: nil, userId: nil, sort: .recent, keyword: nil, onlyPublic: true)
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: TestConfiguration.timeoutMedium) {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:FetchCreationsResponseHandler {
                                (creations: Array<Creation>?, pageInfo: PagingInfo?, error: Error?) -> Void in
                                expect(creations).notTo(beNil())
                                expect(error).to(beNil())
                                expect(pageInfo).notTo(beNil())
                                sender.logout()
                                done()
                            })
                    }
                }
            }

            it("Should return correct value for recommended creations after login") {
                guard let creationId = TestConfiguration.testCreationIdentifier
                    else { return }

                let request = FetchCreationsRequest(page: 1, perPage: 10, recommendedCreationId: creationId)
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: TestConfiguration.timeoutMedium) {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:FetchCreationsResponseHandler {
                            (creations: Array<Creation>?, pageInfo: PagingInfo?, error: Error?) -> Void in
                            expect(creations).notTo(beNil())
                            expect(error).to(beNil())
                            expect(pageInfo).notTo(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }

            it("Should return correct value for recommended creations based by user identifier after login") {
                guard let userId = TestConfiguration.testUserIdentifier
                    else { return }

                let request = FetchCreationsRequest(page: 1, perPage: 10, recommendedUserId: userId)
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: TestConfiguration.timeoutShort) {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:FetchCreationsResponseHandler {
                                (creations: Array<Creation>?, pageInfo: PagingInfo?, error: Error?) -> Void in
                                expect(creations).notTo(beNil())
                                expect(error).to(beNil())
                                expect(pageInfo).notTo(beNil())
                                sender.logout()
                                done()
                            })
                    }
                }
            }

            it("Should return a correct value for partner application after login") {
                guard let partnerApplicationId = TestConfiguration.partnerApplicationId
                else { return }

                let request = FetchCreationsRequest(page: 1, perPage: 10, galleryId: nil, userId: nil, sort: .recent, keyword: nil, partnerApplicationId: partnerApplicationId, onlyPublic: true)
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: TestConfiguration.timeoutShort) {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:FetchCreationsResponseHandler {
                            (creations: Array<Creation>?, pageInfo: PagingInfo?, error: Error?) -> Void in
                            expect(creations).notTo(beNil())
                            expect(error).to(beNil())
                            expect(pageInfo).notTo(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }

            }

            it("Should return a correct value for single creation after login") {
                guard let creationId = TestConfiguration.testCreationIdentifier
                    else { return }

                let request = FetchCreationsRequest(creationId: creationId)
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: TestConfiguration.timeoutShort) {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:FetchCreationsResponseHandler {
                                (creations: Array<Creation>?, _: PagingInfo?, error: Error?) -> Void in
                                expect(creations).notTo(beNil())
                                expect(error).to(beNil())
                                sender.logout()
                                done()
                            })
                    }
                }
            }
            
            it("Should return correct value for creations in challenge after login") {
                let request = FetchCreationsForChallengeRequest(page: nil, perPage: nil, challengeId: "1vIikLL2", sort: .createdAtDesc)
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: TestConfiguration.timeoutMedium) {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:FetchCreationsForChallengeResponseHandler {
                            (creations: Array<Creation>?, pageInfo: PagingInfo?, error: Error?) -> Void in
                            expect(creations).notTo(beNil())
                            expect(error).to(beNil())
                            expect(pageInfo).notTo(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
        }
    }
}
