//
//  SwitchUsersResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 08.08.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class SwitchUsersResponseHandlerSpec: QuickSpec {
    
    override func spec()  {
        describe("Switch users response handler") {
            
            it("Should correctly return users available for switching") {
                let sender = TestComponentsFactory.requestSender
                
                waitUntil(timeout: 10) { done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        let page = 1
                        let pageCount = 10
                        sender.send(SwitchUsersRequest(page: page, perPage: pageCount), withResponseHandler: SwitchUsersResponseHandler()
                            {
                                (users: Array<User>?, pageInfo: PagingInfo?, error: ErrorType?) -> Void in
                                expect(error).to(beNil())
                                expect(users).notTo(beNil())
                                expect(pageInfo).notTo(beNil())
                                done()
                            })
                    }
                }
            }
        }
    }
}