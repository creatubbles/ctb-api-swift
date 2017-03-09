//
//  BubbleRequestSpec.swift
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

class BubbleRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("BubblesFetch request")
        {
            it("Should have proper method")
            {
                let request = BubblesFetchReqest(creationId: "", page: nil, perPage: nil)
                expect(request.method).to(equal(RequestMethod.get))
            }
            
            it("Should have proper endpoint for bubbles source")
            {
                let identifier = "ObjectId"
                expect(BubblesFetchReqest(creationId: identifier, page: nil, perPage: nil).endpoint).to(equal("creations/\(identifier)/bubbles"))
                expect(BubblesFetchReqest(galleryId: identifier, page: nil, perPage: nil).endpoint).to(equal("galleries/\(identifier)/bubbles"))
                expect(BubblesFetchReqest(userId: identifier, page: nil, perPage: nil).endpoint).to(equal("users/\(identifier)/bubbles"))
            }
        }
        
        describe("UpdateBubble request")
        {
            it("Should have proper method")
            {
                let data = UpdateBubbleData(bubbleId: "", colorName: nil)
                let request = UpdateBubbleRequest(data: data)
                expect(request.method).to(equal(RequestMethod.put))
            }
            
            it("Should have proper endpoint")
            {
                let identifier = "bubbleIdentifier"
                let data = UpdateBubbleData(bubbleId: identifier, colorName: nil)
                let request = UpdateBubbleRequest(data: data)
                expect(request.endpoint).to(equal("bubbles/\(identifier)"))
            }
            
            it("Should have proper parameters set")
            {
                let identifier = "identifier"
                let colorName = "TestColorName"
                let data = UpdateBubbleData(bubbleId: identifier, colorName: colorName)
                let request = UpdateBubbleRequest(data: data)
                
                expect(request.parameters["id"] as? String).to(equal(identifier))
                expect(request.parameters["color"] as? String).to(equal(colorName))
            }
        }
        
        describe("Delete bubble request")
        {
            it("Should have proper method")
            {
                let request = DeleteBubbleRequest(bubbleId: "")
                expect(request.method).to(equal(RequestMethod.delete))
            }
            
            it("Should have proper endpoint")
            {
                let identifier = "TestBubbleId"
                let request = DeleteBubbleRequest(bubbleId: identifier)
                expect(request.endpoint).to(equal("bubbles/\(identifier)"))
            }
        }
        
        describe("NewBubble request")
        {
            it("Should have proper method")
            {
                let data = NewBubbleData(userId: "")
                let request = NewBubbleRequest(data: data)
                expect(request.method).to(equal(RequestMethod.post))
            }
            
            it("Should have proper endpoint for bubbling creation")
            {
                let id = "identifier"
                let data = NewBubbleData(creationId: id, colorName: nil, xPosition: nil, yPosition: nil)
                let request = NewBubbleRequest(data: data)
                expect(request.endpoint).to(equal("creations/\(id)/bubbles"))
            }
            
            it("Should have proper endpoint for bubbling user")
            {
                let id = "identifier"
                let data = NewBubbleData(userId: id)
                let request = NewBubbleRequest(data: data)
                expect(request.endpoint).to(equal("users/\(id)/bubbles"))
            }
            
            it("Should have proper endpoint for bubbling gallery")
            {
                let id = "identifier"
                let data = NewBubbleData(galleryId: id)
                let request = NewBubbleRequest(data: data)
                expect(request.endpoint).to(equal("galleries/\(id)/bubbles"))
            }
            
            it("Should have proper parameters when bubbling creation")
            {
                let identifier = "identifier"
                let colorName = "TestColorName"
                let xPosition: Float = 1
                let yPosition: Float = 1
                
                let data = NewBubbleData(creationId: identifier, colorName: colorName, xPosition: xPosition, yPosition: yPosition)
                let request = NewBubbleRequest(data: data)
                expect(request.parameters["creation_id"] as? String).to(equal(identifier))
                expect(request.parameters["color"] as? String).to(equal(colorName))
                expect(request.parameters["x_pos"] as? Float).to(equal(xPosition))
                expect(request.parameters["y_pos"] as? Float).to(equal(yPosition))
            }
        }
    }
}
