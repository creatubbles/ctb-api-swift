//
//  DeclineCommentRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 19.12.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class DeclineCommentRequestSpec: QuickSpec {
    
    override func spec() {
        
        describe("Decline a comment request") {
            
            it("Should have proper endpoint for comment") {
                let commentId = "commentId"
                let request = DeclineCommentRequest(commentId: commentId)
                expect(request.endpoint).to(equal("comments/\(commentId)/approval"))
            }
            
            it("Should have proper method") {
                let commentId = "commentId"
                let request = DeclineCommentRequest(commentId: commentId)
                expect(request.method).to(equal(RequestMethod.delete))
            }
        }
    }
}
