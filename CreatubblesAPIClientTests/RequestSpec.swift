//
//  RequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 08.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import Quick
import Nimble
@testable import CreatubblesAPIClient

class RequestSpec: QuickSpec
{
    override func spec()
    {
        afterSuite
        {
            let sender = RequestSender(settings: TestConfiguration.settings)
            sender.logout()
        }
        
        describe("Profile request")
        {
            it("Should have proper endpoint for me")
            {
                let request = ProfileRequest()
                expect(request.endpoint).to(equal("users/me"))
            }

            it("Should have proper endpoint for another user")
                {
                    let request = ProfileRequest(userId: "TestUser")
                    expect(request.endpoint).to(equal("users/TestUser"))
            }
            
            it("Should have proper method")
            {
                let request = ProfileRequest()
                expect(request.method).to(equal(RequestMethod.GET))
            }
            
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
                        sender.send(ProfileRequest(), withResponseHandler: DummyResponseHandler()
                        {
                            (response, error) -> Void in
                            expect(response).notTo(beNil())
                            expect(error).to(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
        }
        
        describe("Creators and Managers request")
        {
            it("Should have proper endpoint")
            {
                let request = CreatorsAndManagersRequest()
                expect(request.endpoint).to(equal("users"))
            }
            
            it("Should have proper method")
            {
                let request = CreatorsAndManagersRequest()
                expect(request.method).to(equal(RequestMethod.GET))
            }
            
            it("Should have proper parameters set")
            {
                let userId = "TestUserId"
                let page = 1
                let pageCount = 10
                let scope = [CreatorsAndManagersScopeElement.Creators, .Managers]
                let scopeParams = ["creators","managers"]

                let request = CreatorsAndManagersRequest(userId: userId, page: page, perPage: pageCount, scope: scope)
                let params = request.parameters
                expect(params["page"] as? Int).to(equal(page))
                expect(params["per_page"] as? Int).to(equal(pageCount))
                expect(params["user_id"] as? String).to(equal(userId))
                expect(params["scope"] as? Array<String>).to(equal(scopeParams))
            }
            
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
                        sender.send(CreatorsAndManagersRequest(), withResponseHandler: DummyResponseHandler()
                        {
                            (response, error) -> Void in
                            expect(response).notTo(beNil())
                            expect(error).to(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
        }
        
        describe("New creator request")
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
            
            it("Should have proper endpoint")
            {
                let request = creatorRequest
                expect(request.endpoint).to(equal("creators"))
            }
            
            it("Should have proper method")
            {
                let request = creatorRequest
                expect(request.method).to(equal(RequestMethod.POST))
            }
            
            it("Should have proper parameters")
            {
                let request = creatorRequest
                let params = request.parameters
                expect(params["name"] as? String).to(equal(name))
                expect(params["display_name"] as? String).to(equal(displayName))
                expect(params["birth_year"] as? Int).to(equal(birthYear))
                expect(params["birth_month"] as? Int).to(equal(birthMonth))
                expect(params["country"] as? String).to(equal(countryCode))
                expect(params["gender"] as? Int).to(equal(gender.rawValue))
            }
            
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
                        sender.send(creatorRequest, withResponseHandler: DummyResponseHandler()
                        {
                            (response, error) -> Void in
                            expect(response).notTo(beNil())
                            expect(error).to(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
        }
        
        describe("Galleries request")
        {
            it("Should have proper method")
            {
                let request = GalleriesRequest(galleryId: "TestGalleryId")
                expect(request.method).to(equal(RequestMethod.GET))
            }
            
            it("Should have proper endpoint for specified gallery")
            {
                let id = "TestGalleryId"
                let request = GalleriesRequest(galleryId: id)
                expect(request.endpoint).to(equal("galleries/"+id))
            }
            
            it("Should have proper endpoint for list of galleries")
            {
                let request = GalleriesRequest(page: 0, perPage: 20, sort: .Recent, userId: nil)
                expect(request.endpoint).to(equal("galleries"))
            }
            
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
                        sender.send(GalleriesRequest(galleryId: "TestGalleryId"), withResponseHandler: DummyResponseHandler()
                        {
                            (response, error) -> Void in
                            expect(response).notTo(beNil())
                            expect(error).to(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
            
            describe("New Gallery request")
            {
                let timestamp = String(Int(round(NSDate().timeIntervalSince1970 % 1000)))
                let name = "MMGallery"+timestamp
                let galleryDescription = "MMGallery"+timestamp
                let openForAll = false
                let ownerId = "B0SwCGhR"
                let request = NewGalleryRequest(name: name, galleryDescription: galleryDescription, openForAll: openForAll, ownerId: ownerId)
                
                it("Should have proper method")
                {
                    expect(request.method).to(equal(RequestMethod.POST))
                }
                    
                it("Should have proper endpoint")
                {
                    expect(request.endpoint).to(equal("galleries"))
                }
                
                it("Should have proper parameters set")
                {
                    let params = request.parameters
                    expect(params["name"] as? String).to(equal(name))
                    expect(params["description"] as? String).to(equal(galleryDescription))
                    expect(params["open_for_all"] as? Bool).to(equal(openForAll))
                    expect(params["owner_id"] as? String).to(equal(ownerId))
                }
                
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
                            sender.send(request, withResponseHandler: DummyResponseHandler()
                            {
                                (response, error) -> Void in
                                expect(response).notTo(beNil())
                                expect(error).to(beNil())
                                sender.logout()
                                done()
                            })
                        }
                    }
                }
            }
        }
    }
}
