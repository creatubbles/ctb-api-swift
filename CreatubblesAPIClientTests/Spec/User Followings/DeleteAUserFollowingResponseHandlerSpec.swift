//
//  DeleteAUserFollowingResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 20.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class DeleteAUserFollowingResponseHandlerSpec: QuickSpec
{
    private let userId = TestConfiguration.testUserIdentifier
    
    override func spec()
    {
        describe("Delete A User following Response Handler")
        {
            let deleteAUserFollowing = DeleteAUserFollowingRequest(userId: self.userId!)
            
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
                        sender.send(deleteAUserFollowing, withResponseHandler:DeleteAUserFollowingResponseHandler()
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
                    sender.send(deleteAUserFollowing, withResponseHandler:DeleteAUserFollowingResponseHandler()
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
