//
//  GalleriesRequestSpec.swift
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

class GalleriesRequestSpec: QuickSpec {
    override func spec() {
        describe("Galleries request") {
            it("Should have proper method") {
                let request = GalleriesRequest(galleryId: "TestGalleryId")
                expect(request.method) == RequestMethod.get
            }

            it("Should have proper endpoint for specified gallery") {
                let id = "TestGalleryId"
                let request = GalleriesRequest(galleryId: id)
                expect(request.endpoint) == "galleries/"+id
            }

            it("Should have proper endpoint for list of galleries") {
                let request = GalleriesRequest(page: 1, perPage: 20, sort: .recent, filter: nil, userId: nil, query: nil)
                expect(request.endpoint).to(equal("galleries"))
            }

            it("Should have proper endpoint for list of creation galleries") {
                let id = "TestCreationId"
                let request = GalleriesRequest(creationId: id, page: 1, perPage: 20, sort: .recent, filter: nil)
                expect(request.endpoint).to(equal("creations/\(id)/galleries"))
            }

            it("Should have proper endpoint for list of user galleries") {
                let userId = "TestUserId"
                let request = GalleriesRequest(page: 1, perPage: 20, sort: .recent, filter: nil, userId: userId, query: nil)
                expect(request.endpoint).to(equal("users/\(userId)/galleries"))
            }
            
            context("Parameters") {
                it("Should have 'filter[owned_by]' parameter set to true when .owned filter is passed") {
                    let userId = "TestUserId"
                    let request = GalleriesRequest(page: 1, perPage: 20, sort: .recent, filter: GalleriesRequestFilter.owned, userId: userId, query: nil)
                    expect(request.parameters["filter[owned_by]"] as? Bool).to(beTrue())
                }
                
                it("Should have 'filter[shared_with]' parameter set to true when .owned filter is passed") {
                    let userId = "TestUserId"
                    let request = GalleriesRequest(page: 1, perPage: 20, sort: .recent, filter: GalleriesRequestFilter.shared, userId: userId, query: nil)
                    expect(request.parameters["filter[shared_with]"] as? Bool).to(beTrue())
                }
            }
        }
    }
}
