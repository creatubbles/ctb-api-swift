//
//  SwitchUserRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 13.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
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
                expect(request.method).to(equal(RequestMethod.POST))
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
                        (error: ErrorType?) -> Void in
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