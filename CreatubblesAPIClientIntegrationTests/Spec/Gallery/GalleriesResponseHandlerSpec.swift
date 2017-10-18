//
//  GalleriesResponseHandlerSpec.swift
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

class GalleriesResponseHandlerSpec: QuickSpec {
    override func spec() {
        describe("Galleries response handler") {
            it("Should return correct value for many galleries after login") {
                let request = GalleriesRequest(page: 1, perPage: 10, sort: .popular, userId: nil, query: nil)
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: TestConfiguration.timeoutMedium) {
                    done in
                    _ = sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        _ = sender.send(request, withResponseHandler:GalleriesResponseHandler {
                            (galleries: Array<Gallery>?, pageInfo: PagingInfo?, error: Error?) -> Void in
                            expect(galleries).notTo(beNil())
                            expect(error).to(beNil())
                            expect(pageInfo).notTo(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }

            it("Should return correct value for single gallery after login ") {
                let request = GalleriesRequest(galleryId: "wkGDesdl")
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: TestConfiguration.timeoutMedium) {
                    done in
                    _ = sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        _ = sender.send(request, withResponseHandler:GalleriesResponseHandler {
                                (galleries: Array<Gallery>?, pageInfo: PagingInfo?, error: Error?) -> Void in
                                expect(galleries).notTo(beNil())
                                expect(error).to(beNil())
                                expect(pageInfo).to(beNil())
                                sender.logout()
                                done()
                            })
                    }
                }
            }

            it("Should list creation galleries when logged in") {
                guard let identifier = TestConfiguration.testCreationIdentifier
                else { return }

                let request = GalleriesRequest(creationId: identifier, page: nil, perPage: nil, sort: nil)
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: TestConfiguration.timeoutMedium) {
                    done in
                    _ = sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        _ = sender.send(request, withResponseHandler:GalleriesResponseHandler {
                                (galleries: Array<Gallery>?, pageInfo: PagingInfo?, error: Error?) -> Void in
                                expect(galleries).notTo(beNil())
                                expect(error).to(beNil())
                                expect(pageInfo).notTo(beNil())
                                sender.logout()
                                done()
                            })
                    }
                }

            }

            it("Should not return errors when not logged in") {
                let request = GalleriesRequest(page: 0, perPage: 20, sort: .recent, userId: nil, query: nil)
                let sender = TestComponentsFactory.requestSender
                sender.logout()
                waitUntil(timeout: TestConfiguration.timeoutMedium) {
                    done in
                    sender.authenticate()
                    {
                        error in
                        _ = sender.send(request, withResponseHandler:GalleriesResponseHandler {
                            (galleries: Array<Gallery>?, pageInfo: PagingInfo?, error: Error?) -> Void in
                            expect(galleries).notTo(beNil())
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
