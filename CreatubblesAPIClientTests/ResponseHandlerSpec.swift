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
            let sender = TestComponentsFactory.requestSender
            sender.logout()
        }
        
        describe("Profile response handler")
        {
            it("Should return correct value after login")
            {
                let sender = TestComponentsFactory.requestSender
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
                let sender = TestComponentsFactory.requestSender
                sender.logout()
                waitUntil(timeout: 10)
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
                let sender = TestComponentsFactory.requestSender
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
                
                waitUntil(timeout: 10)
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
        
        describe("New creator response handler")
        {
            let timestamp = String(Int(round(NSDate().timeIntervalSince1970 % 1000)))
            let name = "MMCreator"+timestamp
            let displayName = "MMCreator"+timestamp
            let birthYear = 2000
            let birthMonth = 10
            let countryCode = "PL"
            let gender = Gender.Male
            var creatorRequest: NewCreatorRequest { return NewCreatorRequest(name: name, displayName: displayName, birthYear: birthYear,
                birthMonth: birthMonth, countryCode: countryCode, gender: gender) }

            it("Should return correct value after login")
            {
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(creatorRequest, withResponseHandler:NewCreatorResponseHandler()
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
                let sender = TestComponentsFactory.requestSender
                sender.logout()
                waitUntil(timeout: 10)
                {
                    done in
                    sender.send(creatorRequest, withResponseHandler:NewCreatorResponseHandler()
                    {
                        (user: User?, error:NSError?) -> Void in
                        expect(error).notTo(beNil())
                        expect(user).to(beNil())
                        done()
                    })
                }
            }
        }
        
        describe("Galleries response handler")
        {
            it("Should return correct value for many galleries after login ")
            {
                let request = GalleriesRequest(page: 1, perPage: 10, sort: .Popular, userId: nil)
                let sender =  TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:GalleriesResponseHandler()
                        {
                            (galleries: Array<Gallery>?, error: ErrorType?) -> Void in
                            expect(galleries).notTo(beNil())
                            expect(error).to(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
            
            it("Should return correct value for single gallery after login ")
            {
                let request = GalleriesRequest(galleryId: "NrLLiMVC")
                let sender =  TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:GalleriesResponseHandler()
                        {
                            (galleries: Array<Gallery>?, error: ErrorType?) -> Void in
                            expect(galleries).notTo(beNil())
                            expect(error).to(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
            
            it("Should return error when not logged in")
            {
                let request = GalleriesRequest(page: 0, perPage: 20, sort: .Recent, userId: nil)
                let sender = TestComponentsFactory.requestSender
                sender.logout()
                waitUntil(timeout: 10)
                {
                    done in
                    sender.send(request, withResponseHandler:NewCreatorResponseHandler()
                    {
                        (user: User?, error:NSError?) -> Void in
                        expect(error).notTo(beNil())
                        expect(user).to(beNil())
                        done()
                    })
                }
            }
        }
    }
}
