//
//  ActivitiesResponseHandlerSpec.swift
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

class ActivitiesResponseHandlerSpec: QuickSpec {

    override func spec() {

        describe("Activities response handler") {

            it("Should return activities") {

                let request = ActivitiesRequest(page: nil, perPage: nil)
                let sender = TestComponentsFactory.requestSender

                waitUntil(timeout: TestConfiguration.timeoutMedium) { done in

                    sender.login(TestConfiguration.username, password: TestConfiguration.password) { (error: Error?) -> Void in
                        expect(error).to(beNil())

                        sender.send(request, withResponseHandler:ActivitiesResponseHandler { (activities, pageInfo, error) -> (Void) in
                            expect(error).to(beNil())
                            expect(activities).notTo(beNil())
                            expect(pageInfo).notTo(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
        }
    }
}
