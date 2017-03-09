//
//  MyGalleriesResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 09.03.2017.
//  Copyright © 2017 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class MyGalleriesResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("My galleries response handler")
        {
            it("Should return correct values after login")
            {
                let request = MyGalleriesRequest(page: 1, perPage: 10, filter: .owned)
                let sender =  TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    _ = sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        _ = sender.send(request, withResponseHandler:GalleriesResponseHandler()
                        {
                            (galleries: Array<Gallery>?,pageInfo: PagingInfo?, error: Error?) -> Void in
                            expect(galleries).notTo(beNil())
                            expect(error).to(beNil())
                            expect(pageInfo).notTo(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
            
            it("Should return error when not logged in")
            {
                let request = MyGalleriesRequest(page: 1, perPage: 10, filter: .owned)
                let sender =  TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    _ = sender.logout()
                    _ = sender.send(request, withResponseHandler:GalleriesResponseHandler()
                    {
                        (galleries: Array<Gallery>?,pageInfo: PagingInfo?, error: Error?) -> Void in
                        expect(galleries).to(beNil())
                        expect(error).notTo(beNil())
                        expect(pageInfo).to(beNil())
                        done()
                    })
                }
            }
        }
    }
}
