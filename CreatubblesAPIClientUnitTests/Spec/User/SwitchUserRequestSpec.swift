//
//  SwitchUserRequestSpec.swift
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

class SwitchUserRequestSpec: QuickSpec {

    override func spec() {

        describe("Switch user request") {

            it("Should have proper endpoint for me") {
                let request = SwitchUserRequest()
                expect(request.endpoint) == "oauth/token"
            }

            it("Should have proper method") {
                let request = SwitchUserRequest()
                expect(request.method) == RequestMethod.post
            }

            it("Should have proper parameters set") {
                let targetUserId = "TargetUserId"
                let accessToken = "AccessToken"
                let grantType = "user_switch"

                let request = SwitchUserRequest(targetUserId: targetUserId, accessToken: accessToken)
                let params = request.parameters
                expect(params["target_user_id"] as? String) == targetUserId
                expect(params["access_token"] as? String) == accessToken
                expect(params["grant_type"] as? String) == grantType
            }
        }
    }
}
