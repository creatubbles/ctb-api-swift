//
//  SwitchUserRequestSpec.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2016 Creatubbles Pte. Ltd.
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
                expect(request.endpoint).to(equal("oauth/token"))
            }
            
            it("Should have proper method") {
                let request = SwitchUserRequest()
                expect(request.method).to(equal(RequestMethod.post))
            }
            
            it("Should have proper parameters set") {
                let targetUserId = "TargetUserId"
                let accessToken = "AccessToken"
                let grantType = "user_switch"
                
                let request = SwitchUserRequest(targetUserId: targetUserId, accessToken: accessToken)
                let params = request.parameters
                expect(params["target_user_id"] as? String).to(equal(targetUserId))
                expect(params["access_token"] as? String).to(equal(accessToken))
                expect(params["grant_type"] as? String).to(equal(grantType))
            }
            
            it("Should return correct value for the student after signing in as a teacher")
            {
                guard let teacherUsername = TestConfiguration.teacherUsername,
                      let teacherPassword = TestConfiguration.teacherPassword,
                      let studentIdentifier = TestConfiguration.studentIdentifier
                else { return }
                let sender = TestComponentsFactory.requestSender
                
                waitUntil(timeout: 10) { done in
                    sender.login(teacherUsername, password: teacherPassword) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(SwitchUserRequest(targetUserId: studentIdentifier, accessToken: sender.authenticationToken), withResponseHandler: SwitchUserResponseHandler()
                            {
                                (response, error) -> Void in
                                expect(response).notTo(beNil())
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
