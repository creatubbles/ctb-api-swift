//
//  SwitchUserResponseHandlerSpec.swift
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

class SwitchUserResponseHandlerSpec: QuickSpec {

    override func spec() {
        describe("Switch user response handler") {

            it("Should return correct value for the student after signing in as a teacher") {
                let sender = TestComponentsFactory.requestSender
                guard let teacherUsername = TestConfiguration.teacherUsername,
                      let teacherPassword = TestConfiguration.teacherPassword,
                      let studentIdentifier = TestConfiguration.studentIdentifier
                else { return }

                waitUntil(timeout: TestConfiguration.timeoutShort) { done in
                    sender.login(teacherUsername, password: teacherPassword) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                    sender.send(SwitchUserRequest(targetUserId: studentIdentifier, accessToken: sender.authenticationToken), withResponseHandler: SwitchUserResponseHandler {
                            (accessToken, error) -> Void in
                            expect(accessToken).notTo(beNil())
                            expect(error).to(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }

            it("Should return error when not logged in") {
                guard let studentIdentifier = TestConfiguration.studentIdentifier
                else { return }

                let sender = TestComponentsFactory.requestSender
                sender.logout()

                waitUntil(timeout: TestConfiguration.timeoutMedium) {
                    done in
                    sender.authenticate {
                        (err) -> Void in
                        expect(err).to(beNil())

                        sender.send(SwitchUserRequest(targetUserId: studentIdentifier, accessToken: sender.authenticationToken), withResponseHandler: SwitchUserResponseHandler {
                            (accessToken, error) -> Void in
                            expect(error).to(beNil())
                            expect(accessToken).to(beNil())
                            done()
                        })
                    }
                }
            }
        }
    }
}
