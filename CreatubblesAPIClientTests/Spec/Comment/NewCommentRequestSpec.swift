//
//  NewCommentRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class NewCommentRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("New comment request")
        {
            it("Should have a proper method")
            {
                let newCommentData = NewCommentData(creationId: "", text: "That's the best comment you've ever read!")
                let request = NewCommentRequest(data: newCommentData)
                expect(request.method).to(equal(RequestMethod.post))
            }
            it("Should have a correct endpoint when commenting on a creation")
            {
                let id = "identifier"
                let newCommentData = NewCommentData(creationId: id, text: "That's the best comment you've ever read!")
                let request = NewCommentRequest(data: newCommentData)
                expect(request.endpoint).to(equal("creations/\(id)/comments"))
            }
            it("Should have a correct endpoint when commenting on a gallery")
            {
                let id = "identifier"
                let newCommentData = NewCommentData(galleryId: id, text: "That's the best comment you've ever read!")
                let request = NewCommentRequest(data: newCommentData)
                expect(request.endpoint).to(equal("galleries/\(id)/comments"))
            }
            it("Should have a correct endpoint when commenting on a user profile")
            {
                let id = "identifier"
                let newCommentData = NewCommentData(userId: id, text: "That's the best comment you've ever read!")
                let request = NewCommentRequest(data: newCommentData)
                expect(request.endpoint).to(equal("users/\(id)/comments"))
            }
            it("Should have correct parameters when commenting on a creation")
            {
                let identifier = "identifier"
                let text = "That's actually not a smart comment."
                
                let newCommentRequest = NewCommentData(creationId: identifier, text: text)
                let request = NewCommentRequest(data: newCommentRequest)
                expect(request.parameters["text"] as? String).to(equal(text))
            }
        }
    }
}
