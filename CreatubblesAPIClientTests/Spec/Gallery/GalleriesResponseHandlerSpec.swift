//
//  GalleriesResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class GalleriesResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
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
    }
}

