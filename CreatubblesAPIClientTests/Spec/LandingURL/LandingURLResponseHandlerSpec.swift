//
//  LandingURLResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
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
                let sender = RequestSender(settings: TestConfiguration.settings)
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(LandingURLRequest(type: nil), withResponseHandler:LandingURLResponseHandler()
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
                let sender = RequestSender(settings: TestConfiguration.settings)
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(LandingURLRequest(type: .Explore), withResponseHandler:LandingURLResponseHandler()
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
                let sender = RequestSender(settings: TestConfiguration.settings)
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
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
                let sender = RequestSender(settings: TestConfiguration.settings)
                sender.logout()
                
                waitUntil(timeout: 15)
                {
                    done in                    
                    //Have to wait for sender to login with Public Grant
                    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
                    dispatch_after(time, dispatch_get_main_queue(),
                    {
                        sender.send(LandingURLRequest(type: .ForgotPassword), withResponseHandler:LandingURLResponseHandler()
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

