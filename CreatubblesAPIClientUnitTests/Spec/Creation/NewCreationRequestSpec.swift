//
//  NewCreationRequestSpec.swift
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

class NewCreationRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("New creation request")
        {
            it("Should have proper endpoint")
            {
                let request = NewCreationRequest()
                expect(request.endpoint).to(equal("creations"))
            }
            
            it("Should have proper method")
            {
                let request = NewCreationRequest()
                expect(request.method).to(equal(RequestMethod.post))
            }
            
            it("Should have proper parameters set")
            {
                let data = NewCreationData(image: UIImage(), uploadExtension: .jpeg)

                data.name = "TestCreationName"
                data.creatorIds = ["TestCreationId1", "TestCreationId2"]
                data.creationMonth = 1
                data.creationYear = 2016
                data.reflectionText = "TestReflectionText"
                data.reflectionVideoUrl = "https://www.youtube.com/watch?v=L6B_4yMvOiQ"
                
                let request = NewCreationRequest(creationData: data)
                let params = request.parameters
                
                expect(params["name"] as? String).to(equal(data.name))
                expect(params["creator_ids"] as? String).to(equal(data.creatorIds?.joined(separator: ",")))
                expect(params["created_at_year"] as? Int).to(equal(data.creationYear))
                expect(params["created_at_month"] as? Int).to(equal(data.creationMonth))
                expect(params["reflection_text"] as? String).to(equal(data.reflectionText))
                expect(params["reflection_video_url"] as? String).to(equal(data.reflectionVideoUrl))
            }
        }
    }
}
