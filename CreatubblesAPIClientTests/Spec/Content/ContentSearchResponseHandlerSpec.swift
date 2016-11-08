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
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler: ContentSearchResponseHandler()
                        {
                            (responseData) -> (Void) in
                            expect(responseData.error).to(beNil())
                            expect(responseData.objects).notTo(beNil())
                            expect(responseData.pagingInfo).notTo(beNil())
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
                    (responseData) -> (Void) in
                    expect(responseData.error).notTo(beNil())
                    expect(responseData.objects).to(beNil())
                    expect(responseData.pagingInfo).to(beNil())
                    done()
                })
            }
        }
    }
}
