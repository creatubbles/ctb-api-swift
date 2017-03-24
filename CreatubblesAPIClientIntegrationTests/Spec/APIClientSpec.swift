//
//  CreatubblesAPIClientSpec.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2017 Creatubbles Pte. Ltd.
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

class APIClientSpec: QuickSpec
{
    override func spec()
    {        
        describe("APIClient")
        {
            //MARK: - Authentication
            it("Should login and logout")
            {
                let client = APIClient(settings: TestConfiguration.settings)
                client.logout()
                waitUntil(timeout: TestConfiguration.timeoutMedium)
                {
                    done in
                    client.login(username: TestConfiguration.username, password: TestConfiguration.password, completion:
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
                let client = APIClient(settings: TestConfiguration.settings)
                client.logout()
                waitUntil(timeout: TestConfiguration.timeoutShort)
                {
                    done in
                    client.login(username: "WrongUsername", password: "WrongPassword", completion:
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
                let client = APIClient(settings: TestConfiguration.settings)
                waitUntil(timeout: TestConfiguration.timeoutShort)
                {
                    done in
                    client.login(username: TestConfiguration.username, password: TestConfiguration.password, completion:
                    {
                        (error) -> (Void) in
                        expect(error).to(beNil())
                        expect(client.isLoggedIn()).to(beTrue())
                        _ = client.getCurrentUser(
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
                guard TestConfiguration.testUserIdentifier != nil else { return }
                
                let identifier = TestConfiguration.testUserIdentifier!
                let client = APIClient(settings: TestConfiguration.settings)
                waitUntil(timeout: TestConfiguration.timeoutShort)
                {
                    done in
                    client.login(username: TestConfiguration.username, password: TestConfiguration.password, completion:
                    {
                        (error) -> (Void) in
                        expect(error).to(beNil())
                        expect(client.isLoggedIn()).to(beTrue())
                        _ = client.getUser(userId: identifier)
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
                guard TestConfiguration.testUserIdentifier != nil else { return }
                
                let identifier = TestConfiguration.testUserIdentifier!
                let client = APIClient(settings: TestConfiguration.settings)
                waitUntil(timeout: TestConfiguration.timeoutMedium)
                {
                    done in
                    client.login(username: TestConfiguration.username, password: TestConfiguration.password, completion:
                    {
                        (error) -> (Void) in
                        expect(error).to(beNil())
                        expect(client.isLoggedIn()).to(beTrue())
                        _ = client.getCreators(userId: identifier, query: nil, pagingData: nil)
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
                guard TestConfiguration.testUserIdentifier != nil else { return }
                
                let identifier = TestConfiguration.testUserIdentifier!
                let client = APIClient(settings: TestConfiguration.settings)
                waitUntil(timeout: TestConfiguration.timeoutMedium)
                {
                    done in
                    client.login(username: TestConfiguration.username, password: TestConfiguration.password, completion:
                    {
                        (error) -> (Void) in
                        expect(error).to(beNil())
                        expect(client.isLoggedIn()).to(beTrue())
                        _ = client.getManagers(userId: identifier, query: nil, pagingData: nil)
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
//                let timestamp = String(Int(round(NSDate().timeIntervalSince1970 .truncatingRemainder(Double: 1000))))
//                let data = NewCreatorData(name: "CTBAPITestCreator_"+timestamp, displayName: "CTBAPITestCreator_"+timestamp, birthYear: 2016, birthMonth: 1, countryCode: "UK", gender: .Male)
//                let client = CreatubblesAPIClient(settings: TestConfiguration.settings)
//                waitUntil(timeout: TestConfiguration.timeoutShort)
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
                guard TestConfiguration.testGalleryIdentifier != nil else { return }
                
                let identifier = TestConfiguration.testGalleryIdentifier!
                let client = APIClient(settings: TestConfiguration.settings)
                waitUntil(timeout: TestConfiguration.timeoutShort)
                {
                    done in
                    client.login(username: TestConfiguration.username, password: TestConfiguration.password, completion:
                    {
                        (error) -> (Void) in
                        expect(error).to(beNil())
                        expect(client.isLoggedIn()).to(beTrue())
                        _ = client.getGallery(galleryId: identifier)
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
                guard TestConfiguration.testUserIdentifier != nil else { return }
                
                let identifier = TestConfiguration.testUserIdentifier!
                let client = APIClient(settings: TestConfiguration.settings)
                waitUntil(timeout: TestConfiguration.timeoutShort)
                {
                    done in
                    client.login(username: TestConfiguration.username, password: TestConfiguration.password, completion:
                    {
                        (error) -> (Void) in
                        expect(error).to(beNil())
                        expect(client.isLoggedIn()).to(beTrue())
                        _ = client.getGalleries(userId: identifier, pagingData: nil, sort: nil)
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
                let client = APIClient(settings: TestConfiguration.settings)
                waitUntil(timeout: TestConfiguration.timeoutShort)
                {
                    done in
                    client.login(username: TestConfiguration.username, password: TestConfiguration.password, completion:
                    {
                        (error) -> (Void) in
                        expect(error).to(beNil())
                        expect(client.isLoggedIn()).to(beTrue())
                        _ = client.getGalleries(userId: nil, query: nil, pagingData: nil, sort: .popular)
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
                let timestamp = String(Int(round(NSDate().timeIntervalSince1970 .truncatingRemainder(dividingBy: 1000))))
                let data = NewGalleryData(name: "TestGallery_\(timestamp)", galleryDescription: "TestDescription_\(timestamp)", openForAll: false, ownerId: nil)
                let client = APIClient(settings: TestConfiguration.settings)
                waitUntil(timeout: TestConfiguration.timeoutShort)
                {
                    done in
                    client.login(username: TestConfiguration.username, password: TestConfiguration.password, completion:
                    {
                        (error) -> (Void) in
                        expect(error).to(beNil())
                        expect(client.isLoggedIn()).to(beTrue())
                        _ = client.newGallery(data: data)
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
                guard TestConfiguration.testCreationIdentifier != nil else { return }
                
                let identifier = TestConfiguration.testCreationIdentifier!
                let client = APIClient(settings: TestConfiguration.settings)
                waitUntil(timeout: TestConfiguration.timeoutShort)
                {
                    done in
                    client.login(username: TestConfiguration.username, password: TestConfiguration.password, completion:
                    {
                        (error) -> (Void) in
                        expect(error).to(beNil())
                        expect(client.isLoggedIn()).to(beTrue())
                        _ = client.getCreation(creationId: identifier, completion:
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
            
            it("Should fetch all finished UploadSessions")
            {
                let client = APIClient(settings: TestConfiguration.settings)
                waitUntil(timeout: TestConfiguration.timeoutMedium)
                {
                    done in
                    client.login(username: TestConfiguration.username, password: TestConfiguration.password, completion:
                    {
                        (error) -> (Void) in
                        expect(error).to(beNil())
                        expect(client.isLoggedIn()).to(beTrue())
                        _ = client.getAllFinishedUploadSessionPublicData()
                        done()
                    }
                )}
            }
        }
    }
}
