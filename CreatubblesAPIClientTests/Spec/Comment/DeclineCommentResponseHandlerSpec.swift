//
//  DeclineCommentResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 19.12.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class DeclineCommentResponseHandlerSpec: QuickSpec {
    
    override func spec()  {
        describe("Decline a comment response handler") {
            
            it("Should correctly decline a comment") {
                let sender = TestComponentsFactory.requestSender
                
                guard let commentIdentifier = TestConfiguration.testCommentIdentifierToDecline else { return }
                
                waitUntil(timeout: 10) { done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(DeclineCommentRequest(commentId: commentIdentifier), withResponseHandler: DeclineCommentResponseHandler()
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
