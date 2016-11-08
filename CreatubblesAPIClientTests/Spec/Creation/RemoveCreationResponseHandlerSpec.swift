//
//  RemoveCreationResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 11.10.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class RemoveCreationResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("Remove Creation Response Handler")
        {
            it("Should return error when not logged in")
            {
                guard let creationId = TestConfiguration.testCreationIdentifier
                else { return }
                let request = RemoveCreationRequest(creationId: creationId)
                
                let sender = RequestSender(settings: TestConfiguration.settings)
                sender.logout()
                waitUntil(timeout: 20)
                {
                    done in
                    sender.send(request, withResponseHandler: RemoveCreationResponseHandler()
                    {
                        (error: Error?) -> Void in
                        expect(error).notTo(beNil())
                        done()
                    })
                }
            }
        }
        it("Should return error when logged in and creation's name does not exist")
        {
            let creationId = "id"
            let request = RemoveCreationRequest(creationId: creationId)
            let sender = RequestSender(settings: TestConfiguration.settings)
            
            waitUntil(timeout: 10)
            {
                done in
                sender.login(TestConfiguration.username, password: TestConfiguration.password)
                {
                    (error: Error?) -> Void in
                    expect(error).to(beNil())
                    sender.send(request, withResponseHandler:RemoveCreationResponseHandler()
                    {
                        (error: Error?) -> Void in

                        expect(error).notTo(beNil())
                        done()
                    })
                }
            }
        }
    }
}
