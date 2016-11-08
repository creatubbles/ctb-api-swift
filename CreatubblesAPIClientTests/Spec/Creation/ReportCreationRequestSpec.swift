//
//  ReportCreationRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 14.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class ReportCreationRequestSpec: QuickSpec {
    
    override func spec() {
        
        describe("Report creation request") {
            
            it("Should have proper endpoint for creation") {
                let creationId = "creationId"
                let message = "message"
                let request = ReportCreationRequest(creationId: creationId, message: message)
                expect(request.endpoint).to(equal("creations/\(creationId)/report"))
            }
            
            it("Should have proper method") {
                let creationId = "creationId"
                let message = "message"
                let request = ReportCreationRequest(creationId: creationId, message: message)
                expect(request.method).to(equal(RequestMethod.post))
            }
            
            it("Should have proper parameters set") {
                let creationId = "creationId"
                let message = "message"
                
                let request = ReportCreationRequest(creationId: creationId, message: message)
                let params = request.parameters
                expect(params["message"] as? String).to(equal(message))
            }
        }
    }
}
