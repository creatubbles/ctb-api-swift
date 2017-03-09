//
//  BubbleResponseHandlerSpec.swift
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

class BubbleResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
     
        describe("NewBubble response handler")
        {
            it("Should return error when not logged in")
            {
                let data = NewBubbleData(userId: "TestId")
                let request = NewBubbleRequest(data: data)
                
                let requestSender = TestComponentsFactory.requestSender
                requestSender.logout()
                waitUntil(timeout: 20)
                {
                    done in
                    requestSender.send(request, withResponseHandler: NewBubbleResponseHandler()
                    {
                        (bubble, error) -> (Void) in
                        expect(bubble).to(beNil())
                        expect(error).notTo(beNil())
                        done()
                    })
                }
            }
            
            it("Shouldn't return error when logged in")
            {
                guard let identifier = TestConfiguration.testCreationIdentifier
                else { return }
                                
                let data = NewBubbleData(creationId: identifier, colorName: nil, xPosition: nil, yPosition: nil)
                let request = NewBubbleRequest(data: data)
                
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 20)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:NewBubbleResponseHandler()
                        {
                            (bubble, error) -> (Void) in
                            expect(bubble).notTo(beNil())
                            expect(error).to(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
        }
        
        describe("UpdateBubble response handler")
        {
            it("Should return error when not logged in")
            {
                let data = UpdateBubbleData(bubbleId: "Identifier", colorName: "blue")
                let request = UpdateBubbleRequest(data:data)
                
                let requestSender = TestComponentsFactory.requestSender
                requestSender.logout()
                waitUntil(timeout: 100)
                {
                    done in
                    requestSender.send(request, withResponseHandler: UpdateBubbleResponseHandler()
                    {
                        (bubble, error) -> (Void) in
                        expect(bubble).to(beNil())
                        expect(error).notTo(beNil())
                        done()
                    })
                }
            }
            
            it("Shouldn't return error when logged in")
            {
                guard TestConfiguration.testBubbleIdentifier != nil else { return }
                
                let data = UpdateBubbleData(bubbleId: TestConfiguration.testBubbleIdentifier!, colorName: "blue")
                let request = UpdateBubbleRequest(data:data)
                
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 100)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:UpdateBubbleResponseHandler()
                        {
                            (bubble, error) -> (Void) in
                            expect(bubble).notTo(beNil())
                            expect(error).to(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
        }
        
        describe("BubblesFetch Response Handler")
        {
            it("Should return bubbles")
            {
                guard TestConfiguration.testUserIdentifier != nil else { return }
                
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 100)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(BubblesFetchReqest(userId: TestConfiguration.testUserIdentifier!, page: nil, perPage: nil), withResponseHandler:BubblesFetchResponseHandler()
                        {
                            (bubbles, pInfo, error) -> (Void) in
                            expect(error).to(beNil())
                            expect(pInfo).notTo(beNil())
                            expect(bubbles).notTo(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
        }
    }
}
