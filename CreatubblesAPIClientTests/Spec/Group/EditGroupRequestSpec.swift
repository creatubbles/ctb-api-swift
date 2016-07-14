//
//  EditGroupRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 14.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class EditGroupRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("Edit Group Request")
        {
            it("Should have proper method")
            {
                let request = EditGroupRequest(identifier: "", data: EditGroupData())
                expect(request.method).to(equal(RequestMethod.PUT))
            }
            
            it("Should have proper endpoint")
            {
                let identifier = "GroupIdentifier"
                let request = EditGroupRequest(identifier: identifier, data: EditGroupData())
                expect(request.endpoint).to(equal("groups/\(identifier)"))
            }
            
            it("Should have proper parameters set")
            {
                let data = EditGroupData()
                data.name = "TestGroupName"
                data.avatarCreationIdentifier = "TestAvatarIdentifier"
                
                let request = EditGroupRequest(identifier: "", data: data)
                
                expect((request.parameters as NSDictionary).valueForKeyPath("data.type") as? String).to(equal("groups"))
                expect((request.parameters as NSDictionary).valueForKeyPath("data.attributes.name") as? String).to(equal("TestGroupName"))
                expect((request.parameters as NSDictionary).valueForKeyPath("data.relationships.avatar_creation.data.id") as? String).to(equal("TestAvatarIdentifier"))
            }
        }
    }
}
