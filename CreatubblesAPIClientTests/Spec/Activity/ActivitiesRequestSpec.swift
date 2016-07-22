//
//  ActivitiesRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 22.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class ActivitiesRequestSpec: QuickSpec {
    
    override func spec() {
        
        describe("Activities request") {
            
            it("Should have a proper method") {
                let request = ActivitiesRequest(page: nil, perPage: nil)
                expect(request.method).to(equal(RequestMethod.GET))
            }
            
            it("Should have a proper endpoint for activities source") {
                expect(ActivitiesRequest(page: nil, perPage: nil).endpoint).to(equal("activities"))
            }
        }
    }
}