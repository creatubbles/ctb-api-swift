//
//  GroupCreatorsResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 03.08.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class GroupCreatorsResponseHandlerSpec: QuickSpec {
    
    override func spec()  {
        describe("Group creators response handler") {
            
            it("Should correctly return creators associated with the group") {
                let sender = TestComponentsFactory.requestSender
                
                guard let groupIdentifier = TestConfiguration.testGroupIdentifier else { return }
                
                waitUntil(timeout: 10) { done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        let page = 1
                        let pageCount = 10
                        sender.send(GroupCreatorsRequest(groupId: groupIdentifier, page: page, perPage: pageCount), withResponseHandler: GroupCreatorsResponseHandler()
                            {
                                (users: Array<User>?, pageInfo: PagingInfo?, error: Error?) -> Void in
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
