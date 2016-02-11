//
//  RequestSenderSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 08.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import Quick
import Nimble
@testable import CreatubblesAPIClient

class RequestSenderSpec: QuickSpec
{
    override func spec()
    {
        afterEach
        {
            () -> () in
            let settings = TestConfiguration.settings
            let sender = RequestSender(settings: settings)
            sender.logout()
        }
        
        describe("Request Sender")
        {
            it("Should login with proper credentials")
            {
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password, completion:
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        done()
                    })
                }
            }
            
            it("Should throw error with wrong credentials")
            {
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login("wrongEmail@wrong.com", password: "wrong password", completion:
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
