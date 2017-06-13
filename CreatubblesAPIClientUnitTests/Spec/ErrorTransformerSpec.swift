//
//  CreationUploadMapper.swift
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

import Quick
import Nimble
@testable import CreatubblesAPIClient

class ErrorTransformerSpec: QuickSpec {
    private let jsonAPIErrorJSON = "{\"errors\":[{\"code\":\"object-gallery_submission-invalid-creation_id\",\"status\":\"422\",\"title\":\"validation error\",\"detail\":\"has already been taken\",\"source\":{\"pointer\":\"/data/attributes/creation_id\"}}]}"
    private let serverErrorJSON  = "{\"status\":422,\"error\":\"Unprocessable Entity\"}"

    override func spec() {
        describe("Error transformer") {
            it("Should parse JSONAPI error") {
                let dictionary = JSONUtils.dictionaryFromJSONString(self.jsonAPIErrorJSON)
                let errors = ErrorTransformer.errorsFromResponse(dictionary)
                let error = errors.first
                expect(errors).notTo(beNil())
                expect(errors).notTo(beEmpty())
                expect(error).notTo(beNil())
                expect(error?.code) == "object-gallery_submission-invalid-creation_id"
                expect(error?.status) == 422
                expect(error?.title) == "validation error"
                expect(error?.detail) == "has already been taken"
            }

            it("Should parse non-JSONAPI error") {
                let dictionary = JSONUtils.dictionaryFromJSONString(self.serverErrorJSON)
                let errors = ErrorTransformer.errorsFromResponse(dictionary)
                let error = errors.first

                expect(errors).notTo(beNil())
                expect(errors).notTo(beEmpty())
                expect(error).notTo(beNil())
                expect(error?.status) == 422
                expect(error?.title) == "Unprocessable Entity"

            }
        }
    }

}
