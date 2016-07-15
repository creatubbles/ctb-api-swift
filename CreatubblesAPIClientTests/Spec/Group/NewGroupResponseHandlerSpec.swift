//
//  NewGroupResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 14.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
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
                let sender = RequestSender(settings: TestConfiguration.settings)
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
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
                
                let sender = RequestSender(settings: TestConfiguration.settings)
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
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
