//
//  ResponseHandlerSpec.swift
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
                            (user: User?, error: ErrorType?) -> Void in
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
                        (user: User?, error: ErrorType?) -> Void in
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
                            (users: Array<User>?,pageInfo: PagingInfo?, error: ErrorType?) -> Void in
                            expect(error).to(beNil())
                            expect(users).notTo(beNil())
                            expect(pageInfo).notTo(beNil())
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
                    sender.send(CreatorsAndManagersRequest(), withResponseHandler:CreatorsAndManagersResponseHandler()
                    {
                        (users: Array<User>?, pageInfo: PagingInfo?, error: ErrorType?) -> Void in
                        expect(error).notTo(beNil())
                        expect(users).to(beNil())
                        expect(pageInfo).to(beNil())
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
                            (user: User?, error: ErrorType?) -> Void in
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
                        (user: User?, error: ErrorType?) -> Void in
                        expect(error).notTo(beNil())
                        expect(user).to(beNil())
                        done()
                    })
                }
            }
        }
        
        describe("Fetch Creations response handler")
        {
            it("Should return correct value for creations after login")
            {
                let request = FetchCreationsRequest(page: 1, perPage: 10, galleryId: nil, userId: nil, sort: .Recent, keyword: nil)
                let sender =  TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:FetchCreationsResponseHandler
                        {
                            (creations: Array<Creation>?,pageInfo: PagingInfo?, error: ErrorType?) -> Void in
                            expect(creations).notTo(beNil())
                            expect(error).to(beNil())
                            expect(pageInfo).notTo(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
            it("Should return a correct value for single creation after login")
            {
                let request = FetchCreationsRequest(creationId: "YNzO8Rmv")
                let sender =  TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:FetchCreationsResponseHandler
                        {
                            (creations: Array<Creation>?, pageInfo: PagingInfo?, error: ErrorType?) -> Void in
                            expect(creations).notTo(beNil())
                            expect(error).to(beNil())
                            expect(pageInfo).notTo(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
        }
        

        describe("Galleries response handler")
        {
            it("Should return correct value for many galleries after login")
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
                            (galleries: Array<Gallery>?,pageInfo: PagingInfo?, error: ErrorType?) -> Void in
                            expect(galleries).notTo(beNil())
                            expect(error).to(beNil())
                            expect(pageInfo).notTo(beNil())
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
                            (galleries: Array<Gallery>?, pageInfo: PagingInfo?, error: ErrorType?) -> Void in
                            expect(galleries).notTo(beNil())
                            expect(error).to(beNil())
                            expect(pageInfo).to(beNil())
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
                        (user: User?, error:ErrorType?) -> Void in
                        expect(error).notTo(beNil())
                        expect(user).to(beNil())
                        done()
                    })
                }
            }
        }
        
        describe("New Gallery response handler")
        {
            let timestamp = String(Int(round(NSDate().timeIntervalSince1970 % 1000)))
            let name = "MMGallery"+timestamp
            let galleryDescription = "MMGallery"+timestamp
            let openForAll = false
            let ownerId = "B0SwCGhR"
            let request = NewGalleryRequest(name: name, galleryDescription: galleryDescription, openForAll: openForAll, ownerId: ownerId)
            
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
                        sender.send(request, withResponseHandler:NewGalleryResponseHandler
                        {
                            (gallery: Gallery?, error:ErrorType?) -> Void in
                            expect(error).to(beNil())
                            expect(gallery).notTo(beNil())
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
                    sender.send(request, withResponseHandler:NewGalleryResponseHandler
                    {
                        (gallery: Gallery?, error:ErrorType?) -> Void in
                        expect(error).notTo(beNil())
                        expect(gallery).to(beNil())
                        done()
                    })
                }
            }
        }
        
        
        describe("New Creation response handler")
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
                        
                        sender.send(NewCreationRequest(creationData: NewCreationData(image: UIImage())), withResponseHandler:NewCreationResponseHandler()
                        {
                            (creation: Creation?, error:ErrorType?) -> Void in
                            expect(error).to(beNil())
                            expect(creation).notTo(beNil())
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
                    sender.send(NewCreationRequest(creationData: NewCreationData(image:UIImage())), withResponseHandler:NewCreationResponseHandler()
                    {
                        (creation: Creation?, error:ErrorType?) -> Void in
                        expect(error).notTo(beNil())
                        expect(creation).to(beNil())
                        done()
                    })
                }
            }
        }
        
        describe("New Creation Upload response handler")
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
                        sender.send(NewCreationUploadRequest(creationId: "TestCreation"), withResponseHandler:NewCreationUploadResponseHandler()
                        {
                            (creationUpload: CreationUpload?, error:ErrorType?) -> Void in
                            expect(error).to(beNil())
                            expect(creationUpload).notTo(beNil())
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
                    sender.send(NewCreationUploadRequest(creationId: "TestCreation"), withResponseHandler:NewCreationUploadResponseHandler()
                    {
                        (creationUpload: CreationUpload?, error:ErrorType?) -> Void in
                        expect(error).notTo(beNil())
                        expect(creationUpload).to(beNil())
                        done()
                    })
                }
            }
        }
        
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
                        sender.send(BubblesFetchReqest(userId: TestConfiguration.testUserIdentifier!), withResponseHandler:BubblesFetchResponseHandler()
                        {
                            (bubbles, error) -> (Void) in
                            expect(error).to(beNil())
                            expect(bubbles).notTo(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
        }
        
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
    }
}
















