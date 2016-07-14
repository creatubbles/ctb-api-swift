//
//  ReportCommentRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 14.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class ReportCommentRequestSpec: QuickSpec {
    
    override func spec() {
        
        describe("Report comment request") {
            
            it("Should have proper endpoint for comment") {
                let commentId = "commentId"
                let message = "message"
                let request = ReportCommentRequest(commentId: commentId, message: message)
                expect(request.endpoint).to(equal("comments/\(commentId)/report"))
            }
            
            it("Should have proper method") {
                let commentId = "commentId"
                let message = "message"
                let request = ReportCommentRequest(commentId: commentId, message: message)
                expect(request.method).to(equal(RequestMethod.POST))
            }
            
            it("Should have proper parameters set") {
                let commentId = "commentId"
                let message = "message"
                
                let request = ReportCommentRequest(commentId: commentId, message: message)
                let params = request.parameters
                expect(params["message"] as? String).to(equal(message))
            }
        }
    }
}