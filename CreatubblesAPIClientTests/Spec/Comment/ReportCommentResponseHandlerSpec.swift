//
//  ReportCommentResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 14.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class ReportCommentResponseHandlerSpec: QuickSpec {
    
    override func spec()  {
        describe("Report user response handler") {
            
            it("Should correctly report a content of the comment") {
                let sender = TestComponentsFactory.requestSender
                
                guard let commentIdentifier = TestConfiguration.testCommentIdentifier else { return }
                
                waitUntil(timeout: 10) { done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(ReportCommentRequest(commentId: commentIdentifier, message: "message"), withResponseHandler: ReportCommentResponseHandler()
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
