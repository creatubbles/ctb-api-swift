//
//  NotificationsFetchResponseHandlerSpec.swift
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

class NotificationsFetchResponseHandlerSpec: QuickSpec {
    override func spec() {
        describe("NotificationsFetchResponseHandler") {
            it("Should return error when user is not logged in") {
                let request = NotificationsFetchRequest()
                let sender = TestComponentsFactory.requestSender
                sender.logout()

                waitUntil(timeout: TestConfiguration.timeoutShort) {
                    done in
                    _ = sender.send(request, withResponseHandler:NotificationsFetchResponseHandler {
                        (responseData, newNotificationsCount, unreadNotificationsCount, hasUnreadNotifications) -> (Void) in
                        expect(responseData?.objects).to(beNil())
                        expect(responseData?.pagingInfo).to(beNil())
                        expect(responseData?.error).notTo(beNil())
                        expect(newNotificationsCount).to(beNil())
                        expect(unreadNotificationsCount).to(beNil())
                        expect(hasUnreadNotifications).to(beNil())
                        done()
                    })
                }
            }

            it("Should fetch notificaions when user is logged in") {
                let request = NotificationsFetchRequest()
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: TestConfiguration.timeoutShort) {
                    done in
                    _ = sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        _ = sender.send(request, withResponseHandler:NotificationsFetchResponseHandler {
                            (responseData, newNotificationsCount, unreadNotificationsCount, hasUnreadNotifications) -> (Void) in
                            expect(responseData?.objects).notTo(beNil())
                            expect(responseData?.objects).notTo(beEmpty())
                            expect(responseData?.pagingInfo).notTo(beNil())
                            expect(responseData?.error).to(beNil())
                            expect(newNotificationsCount).notTo(beNil())
                            expect(unreadNotificationsCount).notTo(beNil())
                            expect(hasUnreadNotifications).notTo(beNil())
                            done()
                        })
                    }
                }
            }
        }
    }
}
