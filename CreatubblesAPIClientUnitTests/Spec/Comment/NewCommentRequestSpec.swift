//
//  NewCommentRequestSpec.swift
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
