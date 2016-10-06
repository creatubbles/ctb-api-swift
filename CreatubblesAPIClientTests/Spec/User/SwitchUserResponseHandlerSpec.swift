//
//  SwitchUserResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 13.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class SwitchUserResponseHandlerSpec: QuickSpec {
    
    override func spec()  {
        describe("Switch user response handler") {
            
            it("Should return correct value for the student after signing in as a teacher") {
                let sender = TestComponentsFactory.requestSender
                guard let teacherUsername = TestConfiguration.teacherUsername,
                      let teacherPassword = TestConfiguration.teacherPassword,
                      let studentIdentifier = TestConfiguration.studentIdentifier
                else { return }
                
                waitUntil(timeout: 10) { done in
                    sender.login(teacherUsername, password: teacherPassword) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(SwitchUserRequest(targetUserId: studentIdentifier, accessToken: sender.authenticationToken), withResponseHandler: SwitchUserResponseHandler() {
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
                
                waitUntil(timeout: 10) { done in
                    sender.send(SwitchUserRequest(targetUserId: studentIdentifier, accessToken: sender.authenticationToken), withResponseHandler: SwitchUserResponseHandler() {
                            (accessToken, error) -> Void in
                            expect(error).notTo(beNil())
                            expect(accessToken).to(beNil())
                            done()
                        })
                }
            }
        }
    }
}
