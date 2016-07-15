//
//  GroupsRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 14.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class GroupsRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("Groups request")
        {
            it("Should have proper method")
            {
                let request = GroupsRequest()
                expect(request.method).to(equal(RequestMethod.GET))
            }
            
            it("Should have proper endpoint for general groups request")
            {
                let request = GroupsRequest()
                expect(request.endpoint).to(equal("groups"))
            }
            
            it("Should have proper endpoint for single group request")
            {
                let identifier = "TestIdentifier"
                let request = GroupsRequest(groupId: identifier)
                expect(request.endpoint).to(equal("groups/\(identifier)"))
            }
        }
    }
}
