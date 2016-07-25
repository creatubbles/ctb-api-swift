//
//  UsersFollowedByAUserResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 20.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class UsersFollowedByAUserResponseHandlerSpec: QuickSpec
{
    private let page = 1
    private let pageCount = 10
    private let userId = TestConfiguration.testUserIdentifier
    
    override func spec()
    {
        describe("Users Followed By A User Response Handler")
        {
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
                        sender.send(UsersFollowedByAUserRequest(page: self.page, perPage: self.pageCount, userId: self.userId!) , withResponseHandler:
                            UsersFollowedByAUserResponseHandler()
                        {
                            (users: Array<User>?,pageInfo: PagingInfo?, error: ErrorType?) -> Void in
                            expect(error).to(beNil())
                            expect(users).notTo(beNil())
                            expect(pageInfo).notTo(beNil())
                            done()
                        })
                    }
                }
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
                        sender.send(UsersFollowedByAUserRequest(page: self.page, perPage: self.pageCount, userId: self.userId!) , withResponseHandler:
                            UsersFollowedByAUserResponseHandler()
                        {
                            (usersCount: Int?, error: ErrorType?) -> Void in
                            expect(error).to(beNil())
                            expect(usersCount).notTo(beNil())
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
                    sender.send(UsersFollowedByAUserRequest(page: self.page, perPage: self.pageCount, userId: self.userId!) , withResponseHandler:
                        UsersFollowedByAUserResponseHandler()
                    {
                        (users: Array<User>?, pageInfo: PagingInfo?, error: ErrorType?) -> Void in
                        expect(error).notTo(beNil())
                        expect(users).to(beNil())
                        expect(pageInfo).to(beNil())
                        done()
                    })
                }
            }
        }
    }
}
