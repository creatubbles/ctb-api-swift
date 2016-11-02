//
//  FetchToybooCreationResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 02.11.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class FetchToybooCreationResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("Fetch Toyboo Creation response handler")
        {
            it("Should return a correct creation after login")
            {
                let request = FetchToybooCreationRequest(creationId: "kniSnnvO")
                let sender =  TestComponentsFactory.requestSender
                waitUntil(timeout: 200)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler: FetchToybooCreationResponseHandler
                        {
                            (creation, error) -> (Void) in
                            expect(creation).notTo(beNil())
                            expect(error).to(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
            
            it("Should return an error when not logged in")
            {
                let request = FetchToybooCreationRequest(creationId: "kniSnnvO")
                let sender =  TestComponentsFactory.requestSender
                waitUntil(timeout: 20)
                {
                    done in
                    sender.logout()
                    sender.send(request, withResponseHandler: FetchToybooCreationResponseHandler
                    {
                        (creation, error) -> (Void) in
                        expect(creation).to(beNil())
                        expect(error).notTo(beNil())
                        sender.logout()
                        done()
                    })
                }
            }
        }
    }
}
