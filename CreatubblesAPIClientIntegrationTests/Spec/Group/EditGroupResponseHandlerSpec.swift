//
//  EditGroupResponseHandlerSpec.swift
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

class EditGroupResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("Edit Group response handler")
        {
            it("Should Edit group when only name is passed")
            {
                guard let identifier = TestConfiguration.testGroupIdentifier,
                      let name = TestConfiguration.testEditGroupName
                else { return }
                
                let data = EditGroupData()
                data.name = name
                
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    _ = sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        _ = sender.send(EditGroupRequest(identifier: identifier, data:data), withResponseHandler: EditGroupResponseHandler()
                        {
                            (error) -> (Void) in
                            expect(error).to(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
            //TODO: uncomment/remove when status is determined on api - for now creating with creation's id as avatar does not work
//            it("Should edit group when name and avatar_id are passed")
//            {
//                guard let groupIdentifier = TestConfiguration.testGroupIdentifier,
//                      let creationIdentifier = TestConfiguration.testCreationIdentifier
//                else { return }
//                
//                let data = EditGroupData()
//                data.name =  TestConfiguration.testEditGroupName
//                data.avatarCreationIdentifier = creationIdentifier
//                
//                let sender = TestComponentsFactory.requestSender
//                waitUntil(timeout: 10)
//                {
//                    done in
//                    _ = sender.login(TestConfiguration.username, password: TestConfiguration.password)
//                    {
//                        (error: Error?) -> Void in
//                        expect(error).to(beNil())
//                        _ = sender.send(EditGroupRequest(identifier: groupIdentifier, data:data), withResponseHandler: EditGroupResponseHandler()
//                        {
//                            (error) -> (Void) in
//                            expect(error).to(beNil())
//                            sender.logout()
//                            done()
//                        })
//                    }
//                }
//            }
        }
    }
}
