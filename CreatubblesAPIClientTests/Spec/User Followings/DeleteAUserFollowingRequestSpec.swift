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
    private let userId = "TestUserId"
    
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
                        sender.send(deleteUserFollowingRequest, withResponseHandler: DummyResponseHandler()
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
