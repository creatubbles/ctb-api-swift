//
//  BubbleResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
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
                waitUntil(timeout: 10)
                {
                    done in
                    requestSender.send(request, withResponseHandler: NewBubbleResponseHandler()
                    {
                        (error) -> (Void) in
                        expect(error).notTo(beNil())
                        done()
                    })
                }
            }
            
            it("Shouldn't return error when logged in")
            {
                guard TestConfiguration.testUserIdentifier != nil else { return }
                
                let data = NewBubbleData(userId: TestConfiguration.testUserIdentifier!)
                let request = NewBubbleRequest(data: data)
                
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:NewBubbleResponseHandler()
                        {
                            (error) -> (Void) in
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
                waitUntil(timeout: 10)
                {
                    done in
                    requestSender.send(request, withResponseHandler: UpdateBubbleResponseHandler()
                        {
                            (error) -> (Void) in
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
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:UpdateBubbleResponseHandler()
                        {
                            (error) -> (Void) in
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
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
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
