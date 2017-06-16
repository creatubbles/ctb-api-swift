//
//  CommentsRequestSpec.swift
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

class CommentsRequestSpec: QuickSpec {
    override func spec() {
        describe("Comments request") {
            it("Should have a proper method") {
                let request = CommentsRequest(creationId: "", page: nil, perPage: nil)
                expect(request.method) == RequestMethod.get
            }

            it("Should have a proper endpoint for comments source") {
                let identifier = "ObjectId"
                expect(CommentsRequest(creationId: identifier, page: nil, perPage: nil).endpoint) == "creations/\(identifier)/comments"
                expect(CommentsRequest(galleryId: identifier, page: nil, perPage: nil).endpoint) == "galleries/\(identifier)/comments"
                expect(CommentsRequest(userId: identifier, page: nil, perPage: nil).endpoint) == "users/\(identifier)/comments"
            }
        }
    }
}
