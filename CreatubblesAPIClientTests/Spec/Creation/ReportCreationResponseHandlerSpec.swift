//
//  ReportCreationResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 14.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class ReportCreationResponseHandlerSpec: QuickSpec {
    
    override func spec()  {
        describe("Report creation response handler") {
            
            it("Should correctly report a content of the creation") {
                let sender = TestComponentsFactory.requestSender
                
                guard let creationIdentifier = TestConfiguration.testCreationIdentifier else { return }
                
                waitUntil(timeout: 10) { done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(ReportCreationRequest(creationId: creationIdentifier, message: "message"), withResponseHandler: ReportCreationResponseHandler()
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