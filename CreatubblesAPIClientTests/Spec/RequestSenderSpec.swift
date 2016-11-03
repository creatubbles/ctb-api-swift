//
//  RequestSenderSpec.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2016 Creatubbles Pte. Ltd.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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
                sender.logout()
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password, completion:
                    {
                        (error: Error?) -> Void in
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
                        (error: Error?) -> Void in
                        expect(error).notTo(beNil())
                        done()
                    })
                }
            }                        
        }
    }
}
