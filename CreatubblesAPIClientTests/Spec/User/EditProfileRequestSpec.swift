//
//  EditProfileRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 16.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class EditProfileRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("EditProfileRequest")
        {
            it("Should have proper method")
            {
                let request = EditProfileRequest(identifier: "", data: EditProfileData())
                expect(request.method).to(equal(RequestMethod.put))
            }
            
            it("Should have `users/IDENTIFIER/account` endpoint")
            {
                let identifier = "TestUserIdentifier"
                let request = EditProfileRequest(identifier: identifier, data: EditProfileData())
                expect(request.endpoint).to(equal("users/\(identifier)/account"))
            }
            
            it("Should parse parameters properly")
            {
                //TODO
            }
        }
    }
}
