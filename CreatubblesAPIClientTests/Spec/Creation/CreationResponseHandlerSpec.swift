//
//  CreationResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Foundation

import Quick
import Nimble
@testable import CreatubblesAPIClient

class CreationResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("Fetch Creations response handler")
        {
            NSURLCache.sharedURLCache().removeAllCachedResponses()
            it("Should return correct value for creations after login")
            {
                let request = FetchCreationsRequest(page: 1, perPage: 10, galleryId: nil, userId: nil, sort: .Recent, keyword: nil, onlyPublic: true)
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
            
            it("Should return correct value for recommended creations after login")
            {
                guard let creationId = TestConfiguration.testCreationIdentifier
                    else { return }
                
                let request = FetchCreationsRequest(page: 1, perPage: 10, recommendedCreationId: creationId)
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
            
            it("Should return correct value for recommended creations based by user identifier after login")
            {
                guard let userId = TestConfiguration.testUserIdentifier
                    else { return }
                
                let request = FetchCreationsRequest(page: 1, perPage: 10, recommendedUserId: userId)
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
                guard let creationId = TestConfiguration.testCreationIdentifier
                    else { return }
                
                let request = FetchCreationsRequest(creationId: creationId)
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
                                sender.logout()
                                done()
                            })
                    }
                }
            }
        }
    }
}