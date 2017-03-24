//
//  NotificationsViewTrackerResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2017 Creatubbles Pte. Ltd.
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
//


import Quick
import Nimble
@testable import CreatubblesAPIClient

class NotificationsViewTrackerResponseHandlerSpec: QuickSpec
{
    override func spec()
    {

        describe("Notifications View Tracker Response Handler")
        {
            it("Should return error when user is not logged in")
            {
                let request = NotificationsViewTrackerRequest()
                let sender = TestComponentsFactory.requestSender
                sender.logout()
                
                waitUntil(timeout: TestConfiguration.timeoutShort)
                {
                    done in
                    sender.send(request, withResponseHandler:NotificationsViewTrackerResponseHandler()
                    {
                        (error) in
                        expect(error).notTo(beNil())
                        done()
                    })
                }
            }
            
            it("Shouldn't return any errors when user is logged in")
            {
                let request = NotificationsViewTrackerRequest()
                let sender = TestComponentsFactory.requestSender
                
                waitUntil(timeout: TestConfiguration.timeoutShort)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password, completion:
                    {
                        error in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:NotificationsViewTrackerResponseHandler()
                        {
                            (error) in
                            expect(error).to(beNil())
                            done()
                        })
                    })
                }
            }
        }
    }
}
