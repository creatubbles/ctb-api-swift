//
//  MyConnectionRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 04.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class MyConnectionsResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("My Connections response handler")
        {
            it("Should return correct value after login")
            {
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(MyConnectionsRequest(), withResponseHandler:
                            MyConnectionsResponseHandler()
                            {
                                (users: Array<User>?,pageInfo: PagingInfo?, error: Error?) -> Void in
                                expect(error).to(beNil())
                                expect(users).notTo(beNil())
                                expect(pageInfo).notTo(beNil())
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
                    sender.send(MyConnectionsRequest(), withResponseHandler:
                    MyConnectionsResponseHandler()
                        {
                            (users: Array<User>?, pageInfo: PagingInfo?, error: Error?) -> Void in
                            expect(error).notTo(beNil())
                            expect(users).to(beNil())
                            expect(pageInfo).to(beNil())
                            done()
                        })
                }
            }
            
            it("Should return error for other user's my connections when not logged in")
            {
                let sender = TestComponentsFactory.requestSender
                sender.logout()
                
                let page = 1
                let perPage = 10
                let userId = TestConfiguration.testUserIdentifier
                waitUntil(timeout: 10)
                {
                    done in
                    sender.send(MyConnectionsRequest(page: page, perPage: perPage, userId: userId), withResponseHandler:
                        MyConnectionsResponseHandler()
                        {
                            (users: Array<User>?, pageInfo: PagingInfo?, error: Error?) -> Void in
                            expect(error).notTo(beNil())
                            expect(users).to(beNil())
                            expect(pageInfo).to(beNil())
                            done()
                        })
                }
            }
            
            it("Should return correct value for other user's my connections after login")
            {
                let sender = TestComponentsFactory.requestSender
                let page = 1
                let perPage = 10
                let userId = TestConfiguration.testUserIdentifier
                
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(MyConnectionsRequest(page: page, perPage: perPage, userId: userId), withResponseHandler:
                            MyConnectionsResponseHandler()
                            {
                                (users: Array<User>?,pageInfo: PagingInfo?, error: Error?) -> Void in
                                expect(error).to(beNil())
                                expect(users).notTo(beNil())
                                expect(pageInfo).notTo(beNil())
                                done()
                            })
                    }
                }
            }
        }
    }
}
