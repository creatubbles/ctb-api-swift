//
//  LandingURLResponseHandlerSpec.swift
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

class LandingURLResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("LandingURL Response Handler")
        {
            it("Should return all basic urls when logged in")
            {
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    _ = sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        _ = sender.send(LandingURLRequest(type: nil), withResponseHandler:LandingURLResponseHandler()
                            {
                                (landingUrls, error) -> (Void) in
                                expect(error).to(beNil())
                                expect(landingUrls).notTo(beNil())
                                expect(landingUrls).notTo(beEmpty())
                                sender.logout()
                                done()
                            })
                    }
                }
            }
            
            it("Should return single value when logged in")
            {
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(LandingURLRequest(type: .explore), withResponseHandler:LandingURLResponseHandler()
                            {
                                (landingUrls, error) -> (Void) in
                                expect(error).to(beNil())
                                expect(landingUrls).notTo(beNil())
                                expect(landingUrls).notTo(beEmpty())
                                expect(landingUrls?.count).to(equal(1))
                                sender.logout()
                                done()
                            })
                    }
                }
            }
            
            it("Should return landing url for creation value when logged in")
            {
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(LandingURLRequest(creationId: "YNzO8Rmv"), withResponseHandler:LandingURLResponseHandler()
                            {
                                (landingUrls, error) -> (Void) in
                                expect(error).to(beNil())
                                expect(landingUrls).notTo(beNil())
                                expect(landingUrls).notTo(beEmpty())
                                expect(landingUrls?.count).to(equal(1))
                                sender.logout()
                                done()
                            })
                    }
                }
            }
            
            it("Should return landing url for forgotten password when not logged in")
            {
                let sender = TestComponentsFactory.requestSender
                sender.logout()
                
                waitUntil(timeout: 30)
                {
                    done in                    
                    //Have to wait for sender to login with Public Grant

                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute:
                    {
                        sender.send(LandingURLRequest(type: .forgotPassword), withResponseHandler:LandingURLResponseHandler()
                            {
                                (landingUrls, error) -> (Void) in
                                expect(error).to(beNil())
                                expect(landingUrls).notTo(beNil())
                                expect(landingUrls).notTo(beEmpty())
                                expect(landingUrls?.count).to(equal(1))
                                sender.logout()
                                done()
                        })
                    })
                }
            }
        }
    }
}

