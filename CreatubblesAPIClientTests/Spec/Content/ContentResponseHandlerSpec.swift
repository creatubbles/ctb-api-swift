//
//  ContentResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class ContentResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("Content response handler")
        {
            it("Should return recent content after login")
            {
                let request = ContentRequest(type: .Recent, page: 1, perPage: 20, userId: nil)
                let sender = RequestSender(settings: TestConfiguration.settings)
                
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:ContentResponseHandler()
                            {
                                (responseData) -> (Void) in
                                expect(responseData.error).to(beNil())
                                expect(responseData.objects).notTo(beNil())
                                expect(responseData.pagingInfo).notTo(beNil())
                                sender.logout()
                                done()
                            })
                    }
                }
            }
            
            it("Should return trending content after login")
            {
                let request = ContentRequest(type: .Trending, page: 1, perPage: 20, userId: nil)
                let sender = RequestSender(settings: TestConfiguration.settings)
                
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:ContentResponseHandler()
                        {
                            (responseData) -> (Void) in
                            expect(responseData.error).to(beNil())
                            expect(responseData.objects).notTo(beNil())
                            expect(responseData.pagingInfo).notTo(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
            
            it("Should return Connected contents after login")
            {
                let request = ContentRequest(type: .Connected, page: 1, perPage: 20, userId: nil)
                let sender = RequestSender(settings: TestConfiguration.settings)
                
                waitUntil(timeout: 20)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:ContentResponseHandler()
                        {
                            (responseData) -> (Void) in
                            expect(responseData.error).to(beNil())
                            expect(responseData.objects).notTo(beNil())
                            expect(responseData.pagingInfo).notTo(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }

        }
        it("Should return User Bubbled Contents after login")
        {
            let request = ContentRequest(type: .BubbledContents, page: 1, perPage: 20, userId: TestConfiguration.testUserIdentifier)
            let sender = RequestSender(settings: TestConfiguration.settings)
            
            waitUntil(timeout: 20)
            {
                done in
                sender.login(TestConfiguration.username, password: TestConfiguration.password)
                {
                    (error: ErrorType?) -> Void in
                    expect(error).to(beNil())
                    sender.send(request, withResponseHandler: ContentResponseHandler()
                    {
                        (responseData) -> (Void) in
                        expect(responseData.error).to(beNil())
                        expect(responseData.objects).notTo(beNil())
                        expect(responseData.pagingInfo).notTo(beNil())
                        sender.logout()
                        done()
                    })
                }
            }
        }
        it("Should return Contents By A User after login")
        {
            let request = ContentRequest(type: .ContentsByAUser, page: 1, perPage: 20, userId: TestConfiguration.testUserIdentifier)
            let sender = RequestSender(settings: TestConfiguration.settings)
            
            waitUntil(timeout: 20)
            {
                done in
                sender.login(TestConfiguration.username, password: TestConfiguration.password)
                {
                    (error: ErrorType?) -> Void in
                    expect(error).to(beNil())
                    sender.send(request, withResponseHandler: ContentResponseHandler()
                    {
                        (responseData) -> (Void) in
                        expect(responseData.error).to(beNil())
                        expect(responseData.objects).notTo(beNil())
                        expect(responseData.pagingInfo).notTo(beNil())
                        sender.logout()
                        done()
                    })
                }
            }
        }
    }
}
