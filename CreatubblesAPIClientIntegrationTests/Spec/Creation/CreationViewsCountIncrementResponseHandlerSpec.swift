//
//  CreationViewsCountIncrementResponseHandlerSpec.swift
//  CreatubblesAPIClientIntegrationTests
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

class CreationViewsCountIncrementResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("CreationViewsCountIncrementResponseHandler")
        {
            context("user logged in")
            {
                it("Should increment creation views count")
                {
                    guard let creationIdentifier = TestConfiguration.testCreationIdentifier
                        else { return }
                    let requestSender = TestComponentsFactory.requestSender
                    let request = CreationViewsCountIncrementRequest(creationIdentifier: creationIdentifier)

                    waitUntil(timeout: TestConfiguration.timeoutShort) {
                        done in
                        _ = requestSender.login(TestConfiguration.username, password: TestConfiguration.password) {
                            (error: Error?) -> Void in
                            expect(error).to(beNil())
                            _ = requestSender.send(request, withResponseHandler: CreationViewsCountIncrementResponseHandler(completion: {
                                (error) -> (Void) in
                                expect(error).to(beNil())
                                done()
                            }))
                        }
                    }
                }
            }
            
            context("User not logged in")
            {
                it("Should return an error")
                {
                    guard let creationIdentifier = TestConfiguration.testCreationIdentifier
                        else { return }
                    let requestSender = TestComponentsFactory.requestSender
                    let request = CreationViewsCountIncrementRequest(creationIdentifier: creationIdentifier)
                    
                    waitUntil(timeout: TestConfiguration.timeoutShort) {
                        done in
                        _ = requestSender.authenticate {
                            (error: Error?) -> Void in
                            expect(error).to(beNil())
                            _ = requestSender.send(request, withResponseHandler: CreationViewsCountIncrementResponseHandler(completion: {
                                (error) -> (Void) in
                                expect(error).notTo(beNil())
                                done()
                            }))
                        }
                    }
                }
            }
        }
    }
}
