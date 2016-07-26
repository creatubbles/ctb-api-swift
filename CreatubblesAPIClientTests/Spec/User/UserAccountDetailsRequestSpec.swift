//
//  UserAccountDetailsRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 21.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class UserAccountDetailsRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("UserAccountDetails Request")
        {
            it("Should have a proper endpoint")
            {
                let identifier = "TestIdentifier"
                let request = UserAccountDetailsRequest(userId: identifier)
                expect(request.endpoint).to(equal("users/\(identifier)/account"))
            }
            
            it("Should have a GET method")
            {
                let request = UserAccountDetailsRequest(userId: "")
                expect(request.method).to(equal(RequestMethod.GET))
            }
            
            it("Should have no parameters set")
            {
                let request = UserAccountDetailsRequest(userId: "")
                expect(request.parameters).to(beEmpty())
            }
        }
    }
}