//
//  NewGroupRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 14.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class NewGroupRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("New Group Request")
        {
            it("Should have proper method")
            {
                let request = NewGroupRequest(data: NewGroupData(name: ""))
                expect(request.method).to(equal(RequestMethod.POST))
            }
            
            it("Should have proper endpoint")
            {
                let request = NewGroupRequest(data: NewGroupData(name: ""))
                expect(request.endpoint).to(equal("groups"))
            }
            
            it("Should have proper parameters set")
            {
                let data = NewGroupData(name: "TestGroupName", avatarCreationIdentifier: "TestAvatarIdentifier")                                
                let request = NewGroupRequest(data: data)
                
                expect((request.parameters as NSDictionary).valueForKeyPath("data.type") as? String).to(equal("groups"))
                expect((request.parameters as NSDictionary).valueForKeyPath("data.attributes.name") as? String).to(equal("TestGroupName"))
                expect((request.parameters as NSDictionary).valueForKeyPath("data.relationships.avatar_creation.data.id") as? String).to(equal("TestAvatarIdentifier"))
            }
        }
    }
}
