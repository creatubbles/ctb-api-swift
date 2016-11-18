//
//  NewCreationResponseHandlerSpec.swift
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
//


import Quick
import Nimble
@testable import CreatubblesAPIClient

class NewCreationResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("New Creation response handler")
        {
            it("Should return correct value after login")
            {
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        
                        sender.send(NewCreationRequest(creationData: NewCreationData(image: UIImage(), uploadExtension: .jpeg)), withResponseHandler:NewCreationResponseHandler()
                            {
                                (creation: Creation?, error:Error?) -> Void in
                                expect(error).to(beNil())
                                expect(creation).notTo(beNil())
                                done()
                            })
                    }
                }
            }
            
            it("Should return error when not logged in")
            {
                let sender = TestComponentsFactory.requestSender
                sender.logout()
                waitUntil(timeout: 10)
                {
                    done in
                    _ = sender.send(NewCreationRequest(creationData: NewCreationData(image:UIImage(), uploadExtension: .jpeg)), withResponseHandler:NewCreationResponseHandler()
                        {
                            (creation: Creation?, error:Error?) -> Void in
                            expect(error).notTo(beNil())
                            expect(creation).to(beNil())
                            done()
                        })
                }
            }
        }
    }
}
