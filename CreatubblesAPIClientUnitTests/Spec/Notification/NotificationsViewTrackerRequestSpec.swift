//
//  NotificationsViewTrackerRequestSpec.swift
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

class NotificationsViewTrackerRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("Notifications View Tracker Request")
        {
            it("Should use PUT method")
            {
                let request = NotificationsViewTrackerRequest()
                expect(request.method).to(equal(RequestMethod.put))
            }
            
            it("Should have 'notifications/view_tracker' endpoint")
            {
                let request = NotificationsViewTrackerRequest()
                
                expect(request.endpoint).to(equal("notifications/view_tracker"))
            }
        }
    }
}
