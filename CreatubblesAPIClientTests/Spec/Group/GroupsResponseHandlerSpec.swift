//
//  GroupsResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 14.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class GroupsResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("Groups request")
        {
            it("Should return proper value after logging in")
            {
                let sender = RequestSender(settings: TestConfiguration.settings)
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(GroupsRequest(), withResponseHandler: GroupsResponseHandler()
                        {
                            (groups, error) -> (Void) in
                            expect(error).to(beNil())
                            expect(groups).notTo(beNil())
                            expect(groups).notTo(beEmpty())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
        }
    }
}