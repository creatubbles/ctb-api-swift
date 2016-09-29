//
//  DeleteAUserFollowingRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 20.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class DeleteAUserFollowingRequestSpec: QuickSpec
{
    fileprivate let userId = "TestUserId"
    
    override func spec()
    {
        describe("Delete A Usser Following Request")
        {
            let deleteUserFollowingRequest = DeleteAUserFollowingRequest(userId: self.userId)
            
            it("Should have proper endpoint")
            {
                let request = deleteUserFollowingRequest
                expect(request.endpoint).to(equal("users/"+self.userId+"/following"))
            }
            
            it("Should have proper method")
            {
                let request = deleteUserFollowingRequest
                expect(request.method).to(equal(RequestMethod.DELETE))
            }
        }
    }

}
