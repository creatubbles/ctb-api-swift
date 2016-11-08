//
//  ReportUserRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 14.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class ReportUserRequestSpec: QuickSpec {
    
    override func spec() {
        
        describe("Report user request") {
            
            it("Should have proper endpoint for user") {
                let userId = "userId"
                let message = "message"
                let request = ReportUserRequest(userId: userId, message: message)
                expect(request.endpoint).to(equal("users/\(userId)/report"))
            }
            
            it("Should have proper method") {
                let userId = "userId"
                let message = "message"
                let request = ReportUserRequest(userId: userId, message: message)
                expect(request.method).to(equal(RequestMethod.post))
            }
            
            it("Should have proper parameters set") {
                let userId = "userId"
                let message = "message"
                
                let request = ReportUserRequest(userId: userId, message: message)
                let params = request.parameters
                expect(params["message"] as? String).to(equal(message))
            }
        }
    }
}
