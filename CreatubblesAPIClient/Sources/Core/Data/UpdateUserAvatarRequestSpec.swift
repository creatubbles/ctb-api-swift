//
//  AvatarUpdateRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 10.11.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class UpdateUserAvatarRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("AvatarUpdate request")
        {
            it("Should have a proper endpoint")
            {
                guard let userId = TestConfiguration.testUserIdentifier
                    else { return }
                let request = UpdateUserAvatarRequest(userId: userId, data: UpdateAvatarData())
                expect(request.endpoint).to(equal("users/\(userId)/user_avatar"))
            }
            
            it("Should have a proper method")
            {
                guard let userId = TestConfiguration.testUserIdentifier
                    else { return }
                
                let request = UpdateUserAvatarRequest(userId: userId, data: UpdateAvatarData())
                expect(request.method).to(equal(RequestMethod.put))
            }
        }
    }

}
