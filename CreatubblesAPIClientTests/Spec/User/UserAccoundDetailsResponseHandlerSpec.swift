//
//  UserAccoundDetailsResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 21.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class UserAccoundDetailsResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("UserAccoundDetails Response Handler")
        {
            it("Should fetch AccountDetails when user is logged in")
            {
                guard let userIdentifier = TestConfiguration.testUserIdentifier
                else { return }
                let request = UserAccountDetailsRequest(userId: userIdentifier)
                let sender = RequestSender(settings: TestConfiguration.settings)
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:UserAccountDetailsResponseHandler()
                        {
                            (accountDetails, error) -> (Void) in
                            expect(accountDetails).notTo(beNil())
                            expect(error).to(beNil())                            
                            done()
                        })
                    }
                }
            }
        }
    }
}