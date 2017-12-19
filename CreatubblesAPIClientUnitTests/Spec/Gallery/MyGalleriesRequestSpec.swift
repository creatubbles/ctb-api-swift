//
//  MyGalleriesRequestSpec.swift
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

class MyGalleriesRequestSpec: QuickSpec {
    override func spec() {
        describe("Galleries request") {
            it("Should have proper method") {
                let request = MyGalleriesRequest(page: 1, perPage: 20, filter: .none)
                expect(request.method) == RequestMethod.get
            }

            it("Should have proper endpoint for list of galleries") {
                let request = MyGalleriesRequest(page: 1, perPage: 20, filter: .none)
                expect(request.endpoint) == "users/me/galleries"
            }

            it("Shouldn't have filter parameter for all galleries") {
                let request = MyGalleriesRequest(page: 1, perPage: 20, filter: .none)
                let params = request.parameters
                expect(params["filter[only_owned]"] as? Bool).to(beNil())
                expect(params["filter[only_shared]"] as? Bool).to(beNil())
            }

            it("Should have filter[only_owned] parameter for owned galleries") {
                let request = MyGalleriesRequest(page: 1, perPage: 20, filter: .owned)
                let params = request.parameters
                expect(params["filter[only_owned]"] as? Bool).to(beTrue())
            }

            it("Should have filter[only_shared] parameter for shared galleries") {
                let request = MyGalleriesRequest(page: 1, perPage: 20, filter: .shared)
                let params = request.parameters
                expect(params["filter[only_shared]"] as? Bool).to(beTrue())
            }
        }
    }
}
