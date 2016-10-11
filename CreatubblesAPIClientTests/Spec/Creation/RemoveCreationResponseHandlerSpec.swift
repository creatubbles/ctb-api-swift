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
                        (error: ErrorType?) -> Void in
                        expect(error).notTo(beNil())
                        done()
                    })
                }
            }
        }
    }
}
