//
//  GroupCreatorsRequestSpec.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2017 Creatubbles Pte. Ltd.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
