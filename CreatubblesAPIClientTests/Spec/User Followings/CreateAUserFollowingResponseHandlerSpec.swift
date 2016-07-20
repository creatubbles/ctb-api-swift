//
//  CreateAUserFollowingResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 20.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class CreateAUserFollowingResponseHandlerSpec: QuickSpec
{
    private let userId = TestConfiguration.testUserIdentifier

    override func spec()
    {
        describe("Create A User following Response Handler")
        {
            let createAUserFollowing = CreateAUserFollowingRequest(userId: self.userId!)
            
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
                        sender.send(createAUserFollowing, withResponseHandler:CreateAUserFollowingResponseHandler()
                        {
                            (error: ErrorType?) -> Void in
                            expect(error).to(beNil())
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
                    sender.send(createAUserFollowing, withResponseHandler:CreateAUserFollowingResponseHandler()
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).notTo(beNil())
                        done()
                    })
                }
            }
        }
    }
}
