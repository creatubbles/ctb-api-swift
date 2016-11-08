//
//  SwitchUsersRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 08.08.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class SwitchUsersRequestSpec: QuickSpec {
    
    override func spec() {
        
        describe("Switch users request") {
            
            it("Should have proper endpoint") {
                let page = 1
                let pageCount = 10
                let request = SwitchUsersRequest(page: page, perPage: pageCount)
                expect(request.endpoint).to(equal("user_switch/users"))
            }
            
            it("Should have proper method") {
                let page = 1
                let pageCount = 10
                let request = SwitchUsersRequest(page: page, perPage: pageCount)
                expect(request.method).to(equal(RequestMethod.get))
            }
            
            it("Should have proper parameters set") {
                let page = 1
                let pageCount = 10
                let request = SwitchUsersRequest(page: page, perPage: pageCount)
                let params = request.parameters
                expect(params["page"] as? Int).to(equal(page))
                expect(params["per_page"] as? Int).to(equal(pageCount))
            }
        }
    }
}
