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
    override func spec()
    {
        describe("Creators and Managers request")
        {
            it("Should have proper endpoint")
            {
                let request = MyConnectionsRequest()
                expect(request.endpoint).to(equal("users/me/connected_users"))
            }
            
            it("Should have proper method")
            {
                let request = MyConnectionsRequest()
                expect(request.method).to(equal(RequestMethod.GET))
            }
            
            it("Should have proper parameters set")
            {
                let page = 1
                let pageCount = 10
                
                let request = MyConnectionsRequest(page: page, perPage: pageCount)
                let params = request.parameters
                expect(params["page"] as? Int).to(equal(page))
                expect(params["per_page"] as? Int).to(equal(pageCount))
            }
            
            it("Should return correct value after login")
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
        }
        
    }
}
