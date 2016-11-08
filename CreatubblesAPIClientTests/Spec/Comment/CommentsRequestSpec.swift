//
//  CommentsRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class CommentsRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("Comments request")
        {
            it("Should have a proper method")
            {
                let request = CommentsRequest(creationId: "", page: nil, perPage: nil)
                expect(request.method).to(equal(RequestMethod.get))
            }
            
            it("Should have a proper endpoint for comments source")
            {
                let identifier = "ObjectId"
                expect(CommentsRequest(creationId: identifier, page: nil, perPage: nil).endpoint).to(equal("creations/\(identifier)/comments"))
                expect(CommentsRequest(galleryId: identifier, page: nil, perPage: nil).endpoint).to(equal("galleries/\(identifier)/comments"))
                expect(CommentsRequest(userId: identifier, page: nil, perPage: nil).endpoint).to(equal("users/\(identifier)/comments"))
            }
        }
    }
}
