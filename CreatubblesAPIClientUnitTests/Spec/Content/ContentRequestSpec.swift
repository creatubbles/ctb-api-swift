//
//  ContentRequestSpec.swift
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

class ContentRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("Fetch content request")
        {
            it("Should have a proper method")
            {
                let request = ContentRequest(type: .Recent, page: nil, perPage: nil, userId: nil)
                expect(request.method).to(equal(RequestMethod.get))
            }
            
            it("Should have a proper endpoint when fetching Recent content")
            {
                let request = ContentRequest(type: .Recent, page: nil, perPage: nil, userId: nil)
                expect(request.endpoint).to(equal("contents/recent"))
            }
            
            it("Should have a proper endpoint when fetching Trending content")
            {
                let request = ContentRequest(type: .Trending, page: nil, perPage: nil, userId: nil)
                expect(request.endpoint).to(equal("contents/trending"))
            }
            it("Should have a proper endpoint when fetching User Bubbled contents")
            {
                let testId = "testId"
                let request = ContentRequest(type: .BubbledContents, page: nil, perPage: nil, userId: testId)
                expect(request.endpoint).to(equal("users/testId/bubbled_contents"))
            }
            it("Should have a proper endpoint when fetching User Connected contents")
            {
                let request = ContentRequest(type: .Connected, page: nil, perPage: nil)
                expect(request.endpoint).to(equal("contents/connected"))
            }
            it("Should have a proper endpoint when fetching Contents By A User")
            {
                let testId = "testId"
                let request = ContentRequest(type: .ContentsByAUser, page: nil, perPage: nil, userId: testId)
                expect(request.endpoint).to(equal("users/testId/contents"))
            }
            it("Should have a proper endpoint when fetching contents based on Followed Users")
            {
                let request = ContentRequest(type: .Followed, page: nil, perPage: nil)
                expect(request.endpoint).to(equal("contents/followed"))
            }
        }
    }
}
