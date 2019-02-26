//
//  FetchCreationsForHubRequestSpec.swift
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

class FetchCreationsForHubRequestSpec: QuickSpec {
    override func spec() {
        
        let hubId = "hubId"
        
        describe("Creations for hub request") {
            it("Should have proper method") {
                let request = FetchCreationsForHubRequest(page: nil, perPage: nil, hubId: hubId, sort: .createdAtDesc)
                expect(request.method) == RequestMethod.get
            }
            
            it("Should have proper endpoint") {
                let request = FetchCreationsForHubRequest(page: nil, perPage: nil, hubId: hubId, sort: .createdAtDesc)
                expect(request.useExternalNamespace).to(beTrue())
                expect(request.endpoint).to(equal("v3/creations"))
            }
            
            it("Should have proper params") {
                let request = FetchCreationsForHubRequest(page: nil, perPage: nil, hubId: hubId, sort: .createdAtDesc)
                let params = request.parameters
                expect(params["filter[hub_ids][]"] as? String).to(equal(hubId))
                expect(params["sort"] as? String).to(equal(SortMethod.createdAtDesc.rawValue))
            }
        }
    }
}
