//
//  UsersBatchFetcherSpec.swift
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

class UsersBatchFetcherSpec: QuickSpec {
    override func spec() {
        describe("UsersBatchFetcher") {
            it("Should batch fetch users using operation client") {
                guard TestConfiguration.shoulTestBatchFetchers,
                      let identifier = TestConfiguration.testUserIdentifier
                else { return }

                let sender = TestComponentsFactory.requestSender
                var batchFetcher: UsersQueueBatchFetcher!
                waitUntil(timeout: TestConfiguration.timeoutLong) {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password, completion: {
                        (error) -> (Void) in
                        expect(error).to(beNil())
                        expect(sender.isLoggedIn()).to(beTrue())

                        batchFetcher = UsersQueueBatchFetcher(requestSender: sender, userId: identifier, query:nil, scope: .Creators) {
                            (users, error) -> (Void) in
                            expect(users).notTo(beNil())
                            expect(users).notTo(beEmpty())
                            expect(error).to(beNil())
                            done()
                        }
                        batchFetcher.fetch()
                    })
                }
            }

            it("Should batch fetch group users using operation client") {
                guard TestConfiguration.shoulTestBatchFetchers,
                      let identifier = TestConfiguration.testGroupIdentifier
                else { return }

                let sender = TestComponentsFactory.requestSender
                var batchFetcher: GroupUsersQueueBatchFetcher!
                waitUntil(timeout: TestConfiguration.timeoutMedium) {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password, completion: {
                        (error) -> (Void) in
                        expect(error).to(beNil())
                        expect(sender.isLoggedIn()).to(beTrue())

                        batchFetcher = GroupUsersQueueBatchFetcher(requestSender: sender, groupId: identifier) {
                            (users, error) -> (Void) in
                            expect(users).notTo(beNil())
                            expect(users).notTo(beEmpty())
                            expect(error).to(beNil())
                            done()
                        }
                        batchFetcher.fetch()
                    })
                }
            }
        }
    }
}
