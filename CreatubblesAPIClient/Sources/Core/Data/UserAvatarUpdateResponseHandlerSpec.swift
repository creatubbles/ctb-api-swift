//
//  UserAvatarUpdateResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 10.11.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class UserAvatarUpdateResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("UserAvatarUpdate response handler")
        {
            let data = UpdateAvatarData()
            data.avatarCreationIdentifier = TestConfiguration.testCreationIdentifier
            it("Should return error when not logged in")
            {
                guard let userId = TestConfiguration.testUserIdentifier
                else { return }
                
                let request = UserAvatarUpdateRequest(userId: userId, data: data)
                
                let requestSender = TestComponentsFactory.requestSender
                requestSender.logout()
                waitUntil(timeout: 20)
                {
                    done in
                    requestSender.send(request, withResponseHandler: UserAvatarUpdateResponseHandler()
                    {
                        (error) -> (Void) in
                        expect(error).notTo(beNil())
                        done()
                    })
                }
            }
            it("Should return an array of AvatarSuggestion when logged in")
            {
                guard let userId = TestConfiguration.testUserIdentifier
                else { return }

                let request = UserAvatarUpdateRequest(userId: userId, data: data)
                
                let sender = RequestSender(settings: TestConfiguration.settings)
                waitUntil(timeout: 20)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler: UserAvatarUpdateResponseHandler()
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
