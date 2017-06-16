//
//  NewGalleryRequestSpec.swift
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

class NewGalleryRequestSpec: QuickSpec {
    override func spec() {
        describe("New Gallery request") {
            let name = "TestGallery"
            let galleryDescription = "TestGallery"
            let openForAll = false
            let ownerId = "TestOwnerId"
            let request = NewGalleryRequest(name: name, galleryDescription: galleryDescription, openForAll: openForAll, ownerId: ownerId)

            it("Should have proper method") {
                expect(request.method) == RequestMethod.post
            }

            it("Should have proper endpoint") {
                expect(request.endpoint) == "galleries"
            }

            it("Should have proper parameters set") {
                let params = request.parameters
                expect(params["name"] as? String) == name
                expect(params["description"] as? String) == galleryDescription
                expect(params["open_for_all"] as? Bool) == openForAll
                expect(params["owner_id"] as? String) == ownerId
            }
        }
    }
}
