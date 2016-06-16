//
//  ProfileResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class ProfileResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("Profile response handler")
        {
            it("Should return correct value after login")
            {
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(ProfileRequest(), withResponseHandler:ProfileResponseHandler()
                            {
                                (user: User?, error: ErrorType?) -> Void in
                                expect(error).to(beNil())
                                expect(user).notTo(beNil())
                                done()
                            })
                    }
                }
            }
            
            it("Should return error when not logged in")
            {
                let sender = TestComponentsFactory.requestSender
                sender.logout()
                waitUntil(timeout: 10)
                {
                    done in
                    sender.send(ProfileRequest(), withResponseHandler:ProfileResponseHandler()
                        {
                            (user: User?, error: ErrorType?) -> Void in
                            expect(error).notTo(beNil())
                            expect(user).to(beNil())
                            done()
                        })
                }
            }
        }
    }
}
