//
//  GroupCreatorsRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 03.08.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class GroupCreatorsRequestSpec: QuickSpec {
    
    override func spec() {
        
        describe("Group creators request") {
            
            it("Should have proper endpoint for group") {
                let groupId = "groupId"
                let page = 1
                let pageCount = 10
                let request = GroupCreatorsRequest(groupId: groupId, page: page, perPage: pageCount)
                expect(request.endpoint).to(equal("groups/\(groupId)/creators"))
            }
            
            it("Should have proper method") {
                let groupId = "groupId"
                let page = 1
                let pageCount = 10
                let request = GroupCreatorsRequest(groupId: groupId, page: page, perPage: pageCount)
                expect(request.method).to(equal(RequestMethod.get))
            }
            
            it("Should have proper parameters set") {
                let groupId = "groupId"
                let page = 1
                let pageCount = 10
                let request = GroupCreatorsRequest(groupId: groupId, page: page, perPage: pageCount)
                let params = request.parameters
                expect(params["page"] as? Int).to(equal(page))
                expect(params["per_page"] as? Int).to(equal(pageCount))
            }
        }
    }
}
