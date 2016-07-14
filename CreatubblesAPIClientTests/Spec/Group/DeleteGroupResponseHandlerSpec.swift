//
//  DeleteGroupResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 14.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class DeleteGroupResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("Delete Group response handler")
        {
            it("Should handle delete response")
            {
                guard let identifier = TestConfiguration.testGroupIdentifierToDelete
                else { return }
                
                //How to handle this? Group can be removed only once
                let sender = RequestSender(settings: TestConfiguration.settings)
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(DeleteGroupRequest(identifier: identifier), withResponseHandler: DeleteGroupResponseHandler()
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