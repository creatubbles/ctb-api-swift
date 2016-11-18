//
//  AvatarSuggestionsFetchResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 10.11.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class AvatarSuggestionsFetchResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("AvatarSuggestionsFetch response handler")
        {
            it("Should return error when not logged in")
            {
                let request = AvatarSuggestionsFetchRequest()
                
                let requestSender = TestComponentsFactory.requestSender
                requestSender.logout()
                waitUntil(timeout: 10)
                {
                    done in
                    requestSender.send(request, withResponseHandler: AvatarSuggestionsFetchResponseHandler()
                    {
                        (avatarSuggestions, error) -> (Void) in
                        expect(avatarSuggestions).to(beNil())
                        expect(error).notTo(beNil())
                        done()
                    })
                }
            }
            it("Should return an array of AvatarSuggestion when logged in")
            {
                let request = AvatarSuggestionsFetchRequest()

                let sender = RequestSender(settings: TestConfiguration.settings)
                waitUntil(timeout: 20)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:AvatarSuggestionsFetchResponseHandler()
                        {
                            (avatarSuggestions, error) -> (Void) in
                            expect(avatarSuggestions).notTo(beNil())
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
