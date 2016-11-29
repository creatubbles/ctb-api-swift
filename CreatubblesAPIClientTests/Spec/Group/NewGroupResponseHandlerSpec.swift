//
//  NewGroupResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2016 Creatubbles Pte. Ltd.
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

class NewGroupResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("New Group response handler")
        {
            it("Should create new group when only name is passed")
            {
                let data = NewGroupData(name: "TestAvatarGroupName_"+String(NSDate().timeIntervalSince1970))                                
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(NewGroupRequest(data: data), withResponseHandler: NewGroupResponseHandler()
                        {
                            (group, error) -> (Void) in
                            expect(group).notTo(beNil())
                            expect(error).to(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
            
            it("Should create new group when name and avatar_id are passed")
            {
                guard let creationIdentifier = TestConfiguration.testCreationIdentifier
                else { return }
                
                let data = NewGroupData(name: "TestAvatarGroupName_"+String(NSDate().timeIntervalSince1970),
                                        avatarCreationIdentifier: creationIdentifier)
                
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(NewGroupRequest(data: data), withResponseHandler: NewGroupResponseHandler()
                        {
                            (group, error) -> (Void) in
                            expect(group).notTo(beNil())
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
