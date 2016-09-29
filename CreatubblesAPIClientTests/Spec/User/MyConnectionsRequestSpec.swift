//
//  MyConnectionsRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 06.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class MyConnectionsRequestSpec: QuickSpec
{
    fileprivate let page = 1
    fileprivate let pageCount = 10
    fileprivate let userId = "TestUserId"
    
    override func spec()
    {
        describe("Creators and Managers request")
        {
            it("Should have proper endpoint for current user's connections")
            {
                let request = MyConnectionsRequest()
                expect(request.endpoint).to(equal("users/me/connected_users"))
            }
            
            it("Should have a proper endpoint for other user's connections")
            {
                let request = MyConnectionsRequest(page: self.page, perPage: self.pageCount, userId: self.userId)
                expect(request.endpoint).to(equal("users/"+self.userId+"/connected_users"))
            }
            
            it("Should have proper method")
            {
                let request = MyConnectionsRequest()
                expect(request.method).to(equal(RequestMethod.GET))
            }
            
            it("Should have proper parameters set")
            {
                let request = MyConnectionsRequest(page: self.page, perPage: self.pageCount, userId: self.userId)
                let params = request.parameters
                expect(params["page"] as? Int).to(equal(self.page))
                expect(params["per_page"] as? Int).to(equal(self.pageCount))
                expect(params["user_id"] as? String).to(equal(self.userId))
            }
            
            it("Should return correct value after login for current user")
            {
                let sender = RequestSender(settings: TestConfiguration.settings)
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(MyConnectionsRequest(page: nil, perPage: nil), withResponseHandler: DummyResponseHandler()
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
            
            it("Should return correct value after login for a different user")
            {
                let sender = RequestSender(settings: TestConfiguration.settings)
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(MyConnectionsRequest(page: nil, perPage: nil, userId: self.userId), withResponseHandler: DummyResponseHandler()
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
