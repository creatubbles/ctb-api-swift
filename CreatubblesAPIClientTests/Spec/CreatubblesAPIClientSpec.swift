//
//  CreatubblesAPIClientSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 05.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import Quick
import Nimble
@testable import CreatubblesAPIClient

class CreatubblesAPIClientSpec: QuickSpec
{
    override func spec()
    {
        describe("ApiClient Settings")
        {
            it("Have proper fields set")
            {
                let appId = "TestAppId"
                let appSecret = "TestAppSecret"
                let tokenUri = "TestTokenUri"
                let authorizeUri = "TestAuthorizeUri"
                let baseUrl = "TestBaseUrl"
                let apiVersion = "TestApiVersion"
                let apiPrefix = "TestApiPrefix"
                
                let settings = CreatubblesAPIClientSettings(appId: appId, appSecret: appSecret, tokenUri: tokenUri, authorizeUri: authorizeUri, baseUrl: baseUrl, apiVersion: apiVersion, apiPrefix: apiPrefix)
                
                expect(settings.appId).to(equal(appId))
                expect(settings.appSecret).to(equal(appSecret))
                expect(settings.tokenUri).to(equal(tokenUri))            
                expect(settings.authorizeUri).to(equal(authorizeUri))
                expect(settings.baseUrl).to(equal(baseUrl))
                expect(settings.apiVersion).to(equal(apiVersion))
                expect(settings.apiPrefix).to(equal(apiPrefix))
            }
        }
        
        describe("APIClient")
        {
            //MARK: - Authentication
            it("Should login and logout")
            {
                let client = CreatubblesAPIClient(settings: TestConfiguration.settings)
                client.logout()
                waitUntil(timeout: 10)
                {
                    done in
                    client.login(TestConfiguration.username, password: TestConfiguration.password, completion:
                    {
                        (error) -> (Void) in
                        expect(error).to(beNil())
                        expect(client.isLoggedIn()).to(beTrue())
                        client.logout()
                        expect(client.isLoggedIn()).to(beFalse())
                        done()
                    })
                }
            }
            
            //MARK: - Authentication
            it("Should return error on failed login attempt")
            {
                let client = CreatubblesAPIClient(settings: TestConfiguration.settings)
                client.logout()
                waitUntil(timeout: 10)
                {
                    done in
                    client.login("WrongUsername", password: "WrongPassword", completion:
                    {
                        (error) -> (Void) in
                        expect(error).notTo(beNil())
                        expect(client.isLoggedIn()).to(beFalse())
                        client.logout()
                        expect(client.isLoggedIn()).to(beFalse())
                        done()
                    })
                }
            }

            //MARK: - Profile
            it("Should fetch current user")
            {
                let client = CreatubblesAPIClient(settings: TestConfiguration.settings)
                waitUntil(timeout: 10)
                {
                    done in
                    client.login(TestConfiguration.username, password: TestConfiguration.password, completion:
                    {
                        (error) -> (Void) in
                        expect(error).to(beNil())
                        expect(client.isLoggedIn()).to(beTrue())
                        client.getCurrentUser(
                        {
                            (user, error) -> (Void) in
                            expect(user).notTo(beNil())
                            expect(error).to(beNil())
                            done()
                        })
                    })
                }
            }
            
            it("Should fetch user with provided id")
            {
                let identifier = "B0SwCGhR"
                let client = CreatubblesAPIClient(settings: TestConfiguration.settings)
                waitUntil(timeout: 10)
                {
                    done in
                    client.login(TestConfiguration.username, password: TestConfiguration.password, completion:
                    {
                        (error) -> (Void) in
                        expect(error).to(beNil())
                        expect(client.isLoggedIn()).to(beTrue())
                        client.getUser(identifier)
                        {
                            (user, error) -> (Void) in
                            expect(user).notTo(beNil())
                            expect(user?.identifier).to(equal(identifier))
                            expect(error).to(beNil())
                            done()
                        }
                    })
                }
            }
            
            it("Should fetch creators of user")
            {
                let identifier = "B0SwCGhR"
                let client = CreatubblesAPIClient(settings: TestConfiguration.settings)
                waitUntil(timeout: 10)
                {
                    done in
                    client.login(TestConfiguration.username, password: TestConfiguration.password, completion:
                    {
                        (error) -> (Void) in
                        expect(error).to(beNil())
                        expect(client.isLoggedIn()).to(beTrue())
                        client.getCreators(identifier, pagingData: nil)
                        {
                            (users, pageInfo, error) -> (Void) in
                            expect(users).notTo(beNil())
                            expect(pageInfo).notTo(beNil())
                            expect(error).to(beNil())
                            done()
                        }
                    })
                }
            }
            
            it("Should fetch managers of user")
            {
                let identifier = "B0SwCGhR"
                let client = CreatubblesAPIClient(settings: TestConfiguration.settings)
                waitUntil(timeout: 10)
                {
                    done in
                    client.login(TestConfiguration.username, password: TestConfiguration.password, completion:
                    {
                        (error) -> (Void) in
                        expect(error).to(beNil())
                        expect(client.isLoggedIn()).to(beTrue())
                        client.getManagers(identifier, pagingData: nil)
                        {
                            (users,pageInfo, error) -> (Void) in
                            expect(users).notTo(beNil())
                            expect(pageInfo).notTo(beNil())
                            expect(error).to(beNil())
                            done()
                        }
                    })
                }
            }
            
            it("Should add new creator")
            {
                //MM: Commented for now
//                let timestamp = String(Int(round(NSDate().timeIntervalSince1970 % 1000)))
//                let data = NewCreatorData(name: "CTBAPITestCreator_"+timestamp, displayName: "CTBAPITestCreator_"+timestamp, birthYear: 2016, birthMonth: 1, countryCode: "UK", gender: .Male)
//                let client = CreatubblesAPIClient(settings: TestConfiguration.settings)
//                waitUntil(timeout: 10)
//                {
//                    done in
//                    client.login(TestConfiguration.username, password: TestConfiguration.password)
//                    {
//                        (error) -> (Void) in
//                        expect(error).to(beNil())
//                        expect(client.isLoggedIn()).to(beTrue())
//                        
//                        client.newCreator(data, completion:
//                        {
//                            (user, error) -> (Void) in
//                            expect(error).to(beNil())
//                            expect(user).notTo(beNil())
//                            expect(user?.name).to(equal(data.name))
//                            expect(user?.displayName).to(equal(data.displayName))
//                            expect(user?.birthYear).to(equal(data.birthYear))
//                            expect(user?.birthMonth).to(equal(data.birthMonth))
//                            expect(user?.gender).to(equal(data.gender))
//                            expect(user?.countryCode).to(equal(data.countryCode))
//                            done()
//                        })
//                    }
//                }
            }
            
            //MARK: - Gallery
            it("Should fetch gallery with identifier")
            {
                let identifier = "x3pUEOeZ"                
                let client = CreatubblesAPIClient(settings: TestConfiguration.settings)
                waitUntil(timeout: 10)
                {
                    done in
                    client.login(TestConfiguration.username, password: TestConfiguration.password, completion:
                    {
                        (error) -> (Void) in
                        expect(error).to(beNil())
                        expect(client.isLoggedIn()).to(beTrue())
                        client.getGallery(identifier)
                        {
                            (gallery, error) -> (Void) in
                            expect(gallery).notTo(beNil())
                            expect(gallery?.identifier).to(equal(identifier))
                            expect(error).to(beNil())
                            done()
                        }
                    })
                }
            }
            
            it("Should fetch galleries from given user")
            {
                let identifier = "B0SwCGhR"
                let client = CreatubblesAPIClient(settings: TestConfiguration.settings)
                waitUntil(timeout: 10)
                {
                    done in
                    client.login(TestConfiguration.username, password: TestConfiguration.password, completion:
                    {
                        (error) -> (Void) in
                        expect(error).to(beNil())
                        expect(client.isLoggedIn()).to(beTrue())
                        client.getGalleries(identifier, pagingData: nil, sort: nil)
                        {
                            (galleries, pageInfo, error) -> (Void) in
                            expect(galleries).notTo(beNil())
                            expect(galleries).notTo(beEmpty())
                            expect(pageInfo).notTo(beNil())
                            expect(error).to(beNil())
                            done()
                        }
                    })
                }
            }
            
            it("Should fetch some public popular galleries")
            {
                let client = CreatubblesAPIClient(settings: TestConfiguration.settings)
                waitUntil(timeout: 10)
                {
                    done in
                    client.login(TestConfiguration.username, password: TestConfiguration.password, completion:
                    {
                        (error) -> (Void) in
                        expect(error).to(beNil())
                        expect(client.isLoggedIn()).to(beTrue())
                        client.getGalleries(nil, pagingData: nil, sort: .Popular)
                        {
                            (galleries, pageInfo, error) -> (Void) in
                            expect(galleries).notTo(beNil())
                            expect(galleries).notTo(beEmpty())
                            expect(pageInfo).notTo(beNil())
                            expect(error).to(beNil())
                            done()
                        }
                    })
                }
            }
            
            it("Should create new gallery")
            {
                let timestamp = String(Int(round(NSDate().timeIntervalSince1970 % 1000)))
                let data = NewGalleryData(name: "TestGallery_\(timestamp)", galleryDescription: "TestDescription_\(timestamp)", openForAll: false, ownerId: nil)
                let client = CreatubblesAPIClient(settings: TestConfiguration.settings)
                waitUntil(timeout: 10)
                {
                    done in
                    client.login(TestConfiguration.username, password: TestConfiguration.password, completion:
                    {
                        (error) -> (Void) in
                        expect(error).to(beNil())
                        expect(client.isLoggedIn()).to(beTrue())
                        client.newGallery(data)
                        {
                            (gallery, error) -> (Void) in
                            expect(gallery).notTo(beNil())
                            expect(gallery?.name).to(equal(data.name))
                            expect(gallery?.galleryDescription).to(equal(data.galleryDescription))
                            expect(error).to(beNil())
                            done()
                        }
                    })
                }
            }

            //MARK: - Creation
            it("Should fetch specific creation")
            {
                let identifier = "OvM8Xmqj"
                let client = CreatubblesAPIClient(settings: TestConfiguration.settings)
                waitUntil(timeout: 10)
                {
                    done in
                    client.login(TestConfiguration.username, password: TestConfiguration.password, completion:
                    {
                        (error) -> (Void) in
                        expect(error).to(beNil())
                        expect(client.isLoggedIn()).to(beTrue())
                        client.getCreation(identifier, completion:
                        {
                            (creation, error) -> (Void) in
                            expect(creation).notTo(beNil())
                            expect(creation?.identifier).to(equal(identifier))
                            expect(error).to(beNil())
                            done()
        
                        })
                    })
                }
            }                        
        }
    }
}
