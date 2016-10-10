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
                let sender = RequestSender(settings: TestConfiguration.settings)
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
                let sender = RequestSender(settings: TestConfiguration.settings)
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
                let sender = RequestSender(settings: TestConfiguration.settings)
                sender.logout()
                
                waitUntil(timeout: 30)
                {
                    done in                    
                    //Have to wait for sender to login with Public Grant

                    let time: DispatchTime = DispatchTime.now() + Double(Int64(5 * Double(NSEC_PER_SEC)))

                    DispatchQueue.main.asyncAfter(deadline: time, execute:
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

