//
//  EditCreationResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 15.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class EditCreationResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("EditCreationResponseHandlerSpec")
        {
            let data = EditCreationData()
            data.name = "TestEditCreationName"
            data.reflectionText = "Hello darkness my old friend"
            data.reflectionVideoURL = "https://www.youtube.com/watch?v=4zLfCnGVeL4"
            data.creationDate = NSDate(timeIntervalSince1970: 1460751998)
            
            it("Should edit creation when logged in")
            {
                guard let identifier = TestConfiguration.testCreationIdentifier
                else { return }
                
                let request = EditCreationRequest(identifier: identifier, data: data)
                let sender = RequestSender(settings: TestConfiguration.settings)
                
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:EditCreationResponseHandler()
                        {
                            (error: ErrorType?) -> Void in
                            expect(error).to(beNil())                            
                            done()
                        })
                    }
                }
                
            }
        }
    }
}
