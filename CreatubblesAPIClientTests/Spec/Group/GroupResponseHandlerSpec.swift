//
//  GroupResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 14.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class GroupResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("Single Group response handler")
        {
            it("Should return proper value after logging in")
            {
                guard let groupIdentifier = TestConfiguration.testGroupIdentifier
                else { return }
                
                let sender = RequestSender(settings: TestConfiguration.settings)
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(GroupsRequest(groupId: groupIdentifier), withResponseHandler: GroupResponseHandler()
                        {
                            (group, error) -> (Void) in
                            expect(error).to(beNil())
                            expect(group).notTo(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
        }
    }
}
