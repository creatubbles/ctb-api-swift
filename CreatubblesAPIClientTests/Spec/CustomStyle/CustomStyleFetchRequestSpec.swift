//
//  CustomStyleFetchRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient


class CustomStyleFetchRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("CustomStyleFetchRequest")
        {
            it("Should be created with userId")
            {
                _ = CustomStyleFetchRequest(userIdentifier: "")
            }
            
            it("Should have GET method")
            {
                let request = CustomStyleFetchRequest(userIdentifier: "")
                expect(request.method).to(equal(RequestMethod.GET))
            }
            
            it("Should have 'users/USER_IDENTIFIER/custom_style' endpoint")
            {
                let identifier = "TestUserIdentifier"
                let request = CustomStyleFetchRequest(userIdentifier: identifier)
                expect(request.endpoint).to(equal("users/\(identifier)/custom_style"))
            }
        }
    }
}
