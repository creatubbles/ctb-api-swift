//
//  UserAvatarUpdateResponseHandlerSpec.swift
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

class UpdateUserAvatarResponseHandlerSpec: QuickSpec {
    override func spec() {
        describe("UpdateUserAvatar response handler") {
            let data = UpdateAvatarData()
            data.avatarCreationIdentifier = TestConfiguration.testCreationIdentifier
            it("Should return error when not logged in") {
                guard let userId = TestConfiguration.testUserIdentifier
                else { return }

                let request = UpdateUserAvatarRequest(userId: userId, data: data)

                let requestSender = TestComponentsFactory.requestSender
                requestSender.logout()
                waitUntil(timeout: TestConfiguration.timeoutMedium) {
                    done in
                    requestSender.send(request, withResponseHandler: UpdateUserAvatarResponseHandler {
                        (error) -> (Void) in
                        expect(error).notTo(beNil())
                        done()
                    })
                }
            }
            it("Should return an array of AvatarSuggestion when logged in") {
                guard let userId = TestConfiguration.testUserIdentifier
                else { return }

                let request = UpdateUserAvatarRequest(userId: userId, data: data)

                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: TestConfiguration.timeoutMedium) {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler: UpdateUserAvatarResponseHandler {
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
