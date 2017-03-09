//
//  UpdateGalleryRequestSpec.swift
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

class UpdateGalleryRequestSpec: QuickSpec {
    override func spec() {
        
        describe("Update gallery request") {
            
            it("Should have proper method") {
                let data = UpdateGalleryData(galleryId: "12345", name: nil, galleryDescription: nil, openForAll: nil)
                let request = UpdateGalleryRequest(data: data)
                expect(request.method).to(equal(RequestMethod.put))
            }
            
            it("Should have proper endpoint") {
                let galleryId = "12345"
                let data = UpdateGalleryData(galleryId: galleryId, name: nil, galleryDescription: nil, openForAll: nil)
                let request = UpdateGalleryRequest(data: data)
                expect(request.endpoint).to(equal("galleries/\(galleryId)"))
            }
            
            it("Should have proper parameters") {
                let galleryId = "12345"
                let title = "sampleTitle"
                let description = "sampleDescription"
                let data = UpdateGalleryData(galleryId: galleryId, name: title, galleryDescription: description, openForAll: true)
                let request = UpdateGalleryRequest(data: data)
                expect(request.parameters["name"] as? String).to(equal(title))
                expect(request.parameters["description"] as? String).to(equal(description))
                expect(request.parameters["open_for_all"] as? Bool).to(beTrue())
            }
        }
    }
}
