//
//  ResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 09.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import Quick
import Nimble
@testable import CreatubblesAPIClient

class ResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        afterSuite
        {
            let sender = RequestSender(settings: TestConfiguration.settings)
            sender.logout()
        }
        
        describe("Profile response handler")
        {
            it("Should return correct value after login")
            {
                let settings = TestConfiguration.settings
                let sender = RequestSender(settings: settings)
                                
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(ProfileRequest(), withResponseHandler:ProfileResponseHandler()
                        {
                            (user: User?, error:NSError?) -> Void in
                            expect(error).to(beNil())
                            expect(user).notTo(beNil())
                            done()
                        })
                    }
                }
            }
            
            it("Should return error when not logged in")
            {
                let settings = TestConfiguration.settings
                let sender = RequestSender(settings: settings)
                sender.logout()
                
                waitUntil(timeout: 5)
                {
                    done in
                    sender.send(ProfileRequest(), withResponseHandler:ProfileResponseHandler()
                    {
                        (user: User?, error:NSError?) -> Void in
                        expect(error).notTo(beNil())
                        expect(user).to(beNil())
                        done()
                    })
                }
            }
        }
        
        describe("Creators and managers response handler")
            {
                it("Should return correct value after login")
                {
                    let settings = TestConfiguration.settings
                    let sender = RequestSender(settings: settings)
                    
                    waitUntil(timeout: 10)
                    {
                        done in
                        sender.login(TestConfiguration.username, password: TestConfiguration.password)
                        {
                            (error: ErrorType?) -> Void in
                            expect(error).to(beNil())
                            sender.send(CreatorsAndManagersRequest(), withResponseHandler:CreatorsAndManagersResponseHandler()
                            {
                                (users: Array<User>?, error:NSError?) -> Void in
                                expect(error).to(beNil())
                                expect(users).notTo(beNil())
                                done()
                            })
                        }
                    }
                }
                
                it("Should return error when not logged in")
                {
                    let settings = TestConfiguration.settings
                    let sender = RequestSender(settings: settings)
                    sender.logout()
                    
                    waitUntil(timeout: 5)
                    {
                        done in
                        sender.send(CreatorsAndManagersRequest(), withResponseHandler:CreatorsAndManagersResponseHandler()
                        {
                            (users: Array<User>?, error:NSError?) -> Void in
                            expect(error).notTo(beNil())
                            expect(users).to(beNil())
                            done()
                        })
                    }
                }
        }
    }
}
