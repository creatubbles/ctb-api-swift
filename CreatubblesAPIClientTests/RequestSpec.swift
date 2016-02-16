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
        
        describe("Creations request")
        {
            it("Should have a proper method")
            {
               let request = FetchCreationsRequest(page: 1, perPage: 10, galleryId: nil, userId: nil, sort: .Recent, search: nil)
                expect(request.method).to(equal(RequestMethod.GET))
            }
            
            it("Should have a proper endpoint")
            {
                let request = FetchCreationsRequest(page: 1, perPage: 10, galleryId: nil, userId: nil, sort: .Recent, search: nil)
                expect(request.endpoint).to(equal("creations"))
            }
            
            it("Should return a correct value after login")
            {
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(FetchCreationsRequest(page: 1, perPage: 10, galleryId: nil, userId: nil, sort: .Recent, search: nil), withResponseHandler: DummyResponseHandler()
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
                let request = GalleriesRequest(page: 1, perPage: 20, sort: .Recent, userId: nil)
                expect(request.endpoint).to(equal("galleries"))
            }
            
            it("Should return correct value for single gallery after login")
            {
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(GalleriesRequest(galleryId: "NrLLiMVC"), withResponseHandler: DummyResponseHandler()
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
            
            it("Should return correct value for list of galleries after login")
            {
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(GalleriesRequest(page: 1, perPage: 20, sort: .Recent, userId: nil),
                        withResponseHandler: DummyResponseHandler()
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
        
        describe("New creation request")
        {
            it("Should have proper endpoint")
            {
                let request = NewCreationRequest()
                expect(request.endpoint).to(equal("creations"))
            }
            
            it("Should have proper method")
            {
                let request = NewCreationRequest()
                expect(request.method).to(equal(RequestMethod.POST))
            }
            
            it("Should have proper parameters set")
            {
                let name = "TestCreationName"
                let creatorIds = ["TestCreationId1", "TestCreationId2"]
                let creationMonth = 1
                let creationYear = 2016
                let reflectionText = "TestReflectionText"
                let reflectionVideoUrl = "https://www.youtube.com/watch?v=L6B_4yMvOiQ"
                
                let request = NewCreationRequest(name: name, creatorIds: creatorIds, creationYear: creationYear, creationMonth: creationMonth, reflectionText: reflectionText, reflectionVideoUrl: reflectionVideoUrl)
                let params = request.parameters
                
                expect(params["name"] as? String).to(equal(name))
                expect(params["creator_ids"] as? Array<String>).to(equal(creatorIds))
                expect(params["created_at_year"] as? Int).to(equal(creationYear))
                expect(params["created_at_month"] as? Int).to(equal(creationMonth))
                expect(params["reflection_text"] as? String).to(equal(reflectionText))
                expect(params["reflection_video_url"] as? String).to(equal(reflectionVideoUrl))
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
                        sender.send(NewCreationRequest(), withResponseHandler: DummyResponseHandler()
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
        
        describe("New creation upload request")
        {
            it("Should have proper method")
            {
                let request = NewCreationUploadRequest(creationId: "TestId")
                expect(request.method).to(equal(RequestMethod.POST))
            }
            
            it("Should have proper endpoint")
            {
                let identifier = "TestId"
                let request = NewCreationUploadRequest(creationId: identifier)
                expect(request.endpoint).to(equal("creations/"+identifier+"/uploads"))
            }
            
            it("Should have proper params")
            {
                let defaultRequest = NewCreationUploadRequest(creationId: "TestId")
                expect(defaultRequest.parameters["extension"]).to(beNil())
                
                let availableExtensions = [UploadExtension.PNG, .JPG, .JPEG, .H264, .MPEG4, .WMV, .WEBM, .FLV, .OGG, .OGV, .MP4, .M4V, .MOV]
                for availableExtension in availableExtensions
                {
                   let  request = NewCreationUploadRequest(creationId: "TestId", creationExtension: availableExtension)
                    expect(request.parameters["extension"] as? String).to(equal(availableExtension.rawValue))
                }
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
                        sender.send(NewCreationUploadRequest(creationId: "QMH4I18k"), withResponseHandler: DummyResponseHandler()
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
