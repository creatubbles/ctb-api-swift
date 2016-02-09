//
//  RequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 08.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import Quick
import Nimble
@testable import CreatubblesAPIClient

class RequestSpec: QuickSpec
{
    override func spec()
    {
        afterSuite
        {
            let sender = RequestSender(settings: TestConfiguration.settings)
            sender.logout()
        }
        
        describe("Profile request")
        {
            it("Should have proper endpoint for me")
            {
                let request = ProfileRequest()
                expect(request.endpoint).to(equal("users/me"))
            }

            it("Should have proper endpoint for another user")
                {
                    let request = ProfileRequest(userId: "TestUser")
                    expect(request.endpoint).to(equal("users/TestUser"))
            }
            
            it("Should have proper method")
            {
                let request = ProfileRequest()
                expect(request.method).to(equal(RequestMethod.GET))
            }
            
            it("Should return correct value")
            {
                let settings = TestConfiguration.settings
                let sender = RequestSender(settings: settings)

                waitUntil(timeout: 60)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(ProfileRequest(), withResponseHandler: DummyResponseHandler()
                        {
                            (response, error) -> Void in
                            print(response)
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
