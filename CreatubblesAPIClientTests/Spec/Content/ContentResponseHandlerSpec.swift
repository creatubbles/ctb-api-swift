//
//  ContentResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class ContentResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("Content response handler")
        {
            it("Should return recent content after login")
            {
                let request = ContentRequest(type: .Recent, page: 1, perPage: 20)
                let sender = RequestSender(settings: TestConfiguration.settings)
                
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:ContentResponseHandler()
                            {
                                (entries, pageInfo, error) -> (Void) in
                                expect(error).to(beNil())
                                expect(entries).notTo(beNil())
                                expect(pageInfo).notTo(beNil())
                                sender.logout()
                                done()
                            })
                    }
                }
            }
            
            it("Should return trending content after login")
            {
                let request = ContentRequest(type: .Trending, page: 1, perPage: 20)
                let sender = RequestSender(settings: TestConfiguration.settings)
                
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:ContentResponseHandler()
                            {
                                (entries, pageInfo,  error) -> (Void) in
                                expect(error).to(beNil())
                                expect(entries).notTo(beNil())
                                expect(pageInfo).notTo(beNil())
                                sender.logout()
                                done()
                            })
                    }
                }
            }
        }
    }
}
