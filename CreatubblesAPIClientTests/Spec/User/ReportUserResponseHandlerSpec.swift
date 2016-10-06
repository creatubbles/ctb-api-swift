//
//  ReportUserResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 14.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class ReportUserResponseHandlerSpec: QuickSpec {
    
    override func spec()  {
        describe("Report user response handler") {
            
            it("Should correctly report a content of the user") {
                let sender = TestComponentsFactory.requestSender
                
                guard let userIdentifier = TestConfiguration.testUserIdentifier else { return }
                
                waitUntil(timeout: 10) { done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(ReportUserRequest(userId: userIdentifier, message: "message"), withResponseHandler: ReportUserResponseHandler()
                            {
                                (error) -> Void in
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
