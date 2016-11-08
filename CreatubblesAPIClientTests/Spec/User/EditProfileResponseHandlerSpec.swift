//
//  EditProfileResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 16.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class EditProfileResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("EditProfileResponseHandlerSpec")
        {
            it("Should edit creation when logged in")
            {
                guard let profileIdentifier = TestConfiguration.testUserIdentifier,
                      let creationIdentifier = TestConfiguration.testCreationIdentifier
                else { return }
                
                let data = EditProfileData()
                data.avatarCreationIdentifier = creationIdentifier
                
                let request = EditProfileRequest(identifier: profileIdentifier, data: data)
                let sender = RequestSender(settings: TestConfiguration.settings)
                
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:EditProfileResponseHandler()
                        {
                            (error: Error?) -> Void in
                            expect(error).to(beNil())
                            done()
                        })
                    }
                }
                
            }
        }
    }
}
