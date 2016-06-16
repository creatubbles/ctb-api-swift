//
//  BubbleRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
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
                expect(request.method).to(equal(RequestMethod.GET))
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
                expect(request.method).to(equal(RequestMethod.PUT))
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
                expect(request.method).to(equal(RequestMethod.DELETE))
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
                expect(request.method).to(equal(RequestMethod.POST))
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