//
//  CreationRequestSpec.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2016 Creatubbles Pte. Ltd.
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

class CreationRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("Creations request")
        {
            it("Should have a proper method")
            {
                let request = FetchCreationsRequest(page: 1, perPage: 10, galleryId: nil, userId: nil, sort: .recent, keyword: nil, onlyPublic: true)
                expect(request.method).to(equal(RequestMethod.get))
            }
            
            it("Should have a proper endpoint")
            {
                let request = FetchCreationsRequest(page: 1, perPage: 10, galleryId: nil, userId: nil, sort: .recent, keyword: nil, onlyPublic: true)
                expect(request.endpoint).to(equal("creations"))
            }
            
            it("Should have a proper parameters set")
            {
                let testGalleryIdentifier = "TestGalleryIdentifier"
                let testUserIdentifier = "TestUserIdentifier"
                let testKeyword = "TestKeyword"
                let sortType = SortOrder.recent
                
                let request = FetchCreationsRequest(page: 1, perPage: 10, galleryId: testGalleryIdentifier, userId: testUserIdentifier, sort: sortType, keyword: testKeyword, onlyPublic: true)
                
                expect(request.parameters["gallery_id"] as? String).to(equal(testGalleryIdentifier))
                expect(request.parameters["user_id"] as? String).to(equal(testUserIdentifier))
                expect(request.parameters["search"] as? String).to(equal(testKeyword))
                expect(request.parameters["sort"] as? String).to(equal(Request.sortOrderStringValue(sortType)))
                expect(request.parameters["only_public"] as? Bool).to(equal(true))
            }
            
            it("Should have proper endpoint for fetching recommended creations")
            {
                let identifier = "TestIdentifier"
                let creationRequest = FetchCreationsRequest(page: 1, perPage: 0, recommendedCreationId: identifier)
                let userRequest = FetchCreationsRequest(page: 1, perPage: 0, recommendedUserId: identifier)
                
                expect(creationRequest.endpoint).to(equal("creations/\(identifier)/recommended_creations"))
                expect(userRequest.endpoint).to(equal("users/\(identifier)/recommended_creations"))
            }
        }
    }
}
