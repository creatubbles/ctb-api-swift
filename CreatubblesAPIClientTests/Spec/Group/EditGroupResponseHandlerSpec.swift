//
//  EditGroupResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 14.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
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
                guard let identifier = TestConfiguration.testGroupIdentifier
                else { return }
                
                let data = EditGroupData()
                data.name =  "TestEditGroupName_"+String(NSDate().timeIntervalSince1970)
                
                let sender = RequestSender(settings: TestConfiguration.settings)
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(EditGroupRequest(identifier: identifier, data:data), withResponseHandler: EditGroupResponseHandler()
                        {
                            (error) -> (Void) in
                            expect(error).to(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
            
            it("Should edit group when name and avatar_id are passed")
            {
                guard let groupIdentifier = TestConfiguration.testGroupIdentifier,
                      let creationIdentifier = TestConfiguration.testCreationIdentifier
                else { return }
                
                let data = EditGroupData()
                data.name =  "TestEditGroupName_"+String(NSDate().timeIntervalSince1970)
                data.avatarCreationIdentifier = creationIdentifier
                
                let sender = RequestSender(settings: TestConfiguration.settings)
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(EditGroupRequest(identifier: groupIdentifier, data:data), withResponseHandler: EditGroupResponseHandler()
                        {
                            (error) -> (Void) in
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
