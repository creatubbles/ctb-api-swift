//
//  CreatorsAndManagersRequestSpec.swift
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

class CreatorsAndManagersRequestSpec: QuickSpec {
    override func spec() {
        describe("Creators and Managers request") {
            it("Should have proper endpoint") {
                let request = CreatorsAndManagersRequest()
                expect(request.endpoint) == "users"
            }

            it("Should have proper method") {
                let request = CreatorsAndManagersRequest()
                expect(request.method) == RequestMethod.get
            }

            it("Should have proper parameters set") {
                let userId = "TestUserId"
                let query = "TestQuery"
                let page = 1
                let pageCount = 10
                let scope = CreatorsAndManagersScopeElement.Creators

                let request = CreatorsAndManagersRequest(userId: userId, query: query, page: page, perPage: pageCount, scope: scope)
                let params = request.parameters
                expect(params["page"] as? Int) == page
                expect(params["per_page"] as? Int) == pageCount
                expect(params["user_id"] as? String) == userId
                expect(params["query"] as? String) == query
                expect(params["scope"] as? String) == scope.rawValue
            }
        }
    }
}
