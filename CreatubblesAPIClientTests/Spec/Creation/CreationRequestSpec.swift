//
//  CreationRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
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
                let request = FetchCreationsRequest(page: 1, perPage: 10, galleryId: nil, userId: nil, sort: .Recent, keyword: nil, onlyPublic: true)
                expect(request.method).to(equal(RequestMethod.GET))
            }
            
            it("Should have a proper endpoint")
            {
                let request = FetchCreationsRequest(page: 1, perPage: 10, galleryId: nil, userId: nil, sort: .Recent, keyword: nil, onlyPublic: true)
                expect(request.endpoint).to(equal("creations"))
            }
            
            it("Should have a proper parameters set")
            {
                let testGalleryIdentifier = "TestGalleryIdentifier"
                let testUserIdentifier = "TestUserIdentifier"
                let testKeyword = "TestKeyword"
                let sortType = SortOrder.Recent
                
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
