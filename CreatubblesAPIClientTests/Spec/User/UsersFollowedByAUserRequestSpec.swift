//
//  UsersFollowedByAUserRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 20.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class UsersFollowedByAUserRequestSpec: QuickSpec
{
    fileprivate let page = 1
    fileprivate let pageCount = 10
    fileprivate let userId = "TestUserId"
    
    override func spec()
    {
        describe("Users Followed By A User Request")
        {
            it("Should have a proper endpoint")
            {
                let request = UsersFollowedByAUserRequest(page: self.page, perPage: self.pageCount, userId: self.userId)
                expect(request.endpoint).to(equal("users/"+self.userId+"/followed_users"))
            }
            
            it("Should have proper method")
            {
                let request = UsersFollowedByAUserRequest(userId: self.userId)
                expect(request.method).to(equal(RequestMethod.GET))
            }
            
            it("Should have proper parameters set")
            {
                let request = UsersFollowedByAUserRequest(page: self.page, perPage: self.pageCount, userId: self.userId)
                let params = request.parameters
                expect(params["page"] as? Int).to(equal(self.page))
                expect(params["per_page"] as? Int).to(equal(self.pageCount))
                expect(params["user_id"] as? String).to(equal(self.userId))
            }
        }
    }
}
