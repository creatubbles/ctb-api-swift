//
//  EditGroupRequestSpec.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2017 Creatubbles Pte. Ltd.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
                expect(request.method).to(equal(RequestMethod.put))
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
                
                expect((request.parameters as NSDictionary).value(forKeyPath: "data.type") as? String).to(equal("groups"))
                expect((request.parameters as NSDictionary).value(forKeyPath: "data.attributes.name") as? String).to(equal("TestGroupName"))
                expect((request.parameters as NSDictionary).value(forKeyPath: "data.relationships.avatar_creation.data.id") as? String).to(equal("TestAvatarIdentifier"))
            }
        }
    }
}
