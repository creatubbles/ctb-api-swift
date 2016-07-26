//
//  ContentSearchResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 25.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class ContentSearchResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("Content search response handler")
        {
            it("Should return recent content after login")
            {
                let request = ContentSearchRequest(query: "plant", page: 1, perPage: 20)
                let sender = RequestSender(settings: TestConfiguration.settings)
                
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler: ContentSearchResponseHandler()
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
        }
        
        it("Should return error when not logged in")
        {
            let request = ContentSearchRequest(query: "plant", page: 1, perPage: 20)
            let sender = RequestSender(settings: TestConfiguration.settings)
            
            sender.logout()
            waitUntil(timeout: 10)
            {
                done in
                sender.send(request, withResponseHandler: ContentSearchResponseHandler()
                {
                    (entries, pageInfo, error) -> (Void) in
                    expect(error).notTo(beNil())
                    expect(entries).to(beNil())
                    expect(pageInfo).to(beNil())
                    done()
                })
            }
        }
    }
}
