//
//  CreateAUserFollowingRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 20.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class CreateAUserFollowingRequestSpec: QuickSpec
{
    private let userId = "TestUserId"

    override func spec()
    {
        describe("Create A Usser Following Request")
        {
            let createUserFollowingRequest = CreateAUserFollowingRequest(userId: self.userId)
            
            it("Should have proper endpoint")
            {
                let request = createUserFollowingRequest
                expect(request.endpoint).to(equal("users/"+self.userId+"/following"))
            }
            
            it("Should have proper method")
            {
                let request = createUserFollowingRequest
                expect(request.method).to(equal(RequestMethod.POST))
            }
            
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
                        sender.send(createUserFollowingRequest, withResponseHandler: DummyResponseHandler()
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
