//
//  MyConnectionsRequestSpec.swift
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

class MyConnectionsRequestSpec: QuickSpec {
    fileprivate let page = 1
    fileprivate let pageCount = 10
    fileprivate let userId = "TestUserId"

    override func spec() {
        describe("Creators and Managers request") {
            it("Should have proper endpoint for current user's connections") {
                let request = MyConnectionsRequest()
                expect(request.endpoint) == "users/me/connected_users"
            }

            it("Should have a proper endpoint for other user's connections") {
                let request = MyConnectionsRequest(page: self.page, perPage: self.pageCount, userId: self.userId)
                expect(request.endpoint) == "users/"+self.userId+"/connected_users"
            }

            it("Should have proper method") {
                let request = MyConnectionsRequest()
                expect(request.method) == RequestMethod.get
            }

            it("Should have proper parameters set") {
                let request = MyConnectionsRequest(page: self.page, perPage: self.pageCount, userId: self.userId)
                let params = request.parameters
                expect(params["page"] as? Int) == self.page
                expect(params["per_page"] as? Int) == self.pageCount
                expect(params["user_id"] as? String) == self.userId
            }
        }
    }
}
