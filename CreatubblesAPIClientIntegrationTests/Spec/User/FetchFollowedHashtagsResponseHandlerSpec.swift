//
//  FetchFollowedHashtagsResponseHandlerSpec.swift
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

class FetchFollowedHashtagsResponseHandlerSpec: QuickSpec {
    fileprivate let page = 1
    fileprivate let pageCount = 10
    fileprivate let userId = TestConfiguration.testUserIdentifier
    
    override func spec() {
        describe("Followed hashtags Response Handler") {
            it("Should return correct value after login") {
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: TestConfiguration.timeoutShort) {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(FetchFollowedHashtagsRequest(page: self.page, perPage: self.pageCount, userId: self.userId!), withResponseHandler:
                            FetchFollowedHashtagsResponseHandler {
                                (hashtags: Array<Hashtag>?, pageInfo: PagingInfo?, error: Error?) -> Void in
                                expect(error).to(beNil())
                                expect(hashtags).notTo(beNil())
                                expect(pageInfo).notTo(beNil())
                                done()
                        })
                    }
                }
            }
            
            it("Should not return errors when not logged in") {
                let sender = TestComponentsFactory.requestSender
                sender.logout()
                waitUntil(timeout: TestConfiguration.timeoutShort) {
                    done in
                    
                    sender.authenticate()
                        {
                            error in
                            sender.send(FetchFollowedHashtagsRequest(page: self.page, perPage: self.pageCount, userId: self.userId!), withResponseHandler:
                                FetchFollowedHashtagsResponseHandler {
                                    (hashtags: Array<Hashtag>?, pageInfo: PagingInfo?, error: Error?) -> Void in
                                    expect(error).to(beNil())
                                    expect(hashtags).notTo(beNil())
                                    expect(pageInfo).notTo(beNil())
                                    done()
                            })
                    }
                }
            }
        }
    }
}
