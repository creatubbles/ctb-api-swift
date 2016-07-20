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
        describe("Create A User Following Request")
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
        }
    }
}
