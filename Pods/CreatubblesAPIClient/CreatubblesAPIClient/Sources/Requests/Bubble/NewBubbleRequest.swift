//
//  NewBubbleRequest.swift
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


import UIKit

class NewBubbleRequest: Request
{
    override var method: RequestMethod  { return .post }
    override var endpoint: String
    {
        switch data.type
        {
            case .creation: return "creations/\(data.bubbledObjectIdentifier)/bubbles"
            case .gallery:  return "galleries/\(data.bubbledObjectIdentifier)/bubbles"
            case .user:     return "users/\(data.bubbledObjectIdentifier)/bubbles"
        }
    }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    
    fileprivate let data: NewBubbleData
    
    init(data: NewBubbleData)
    {
        self.data = data
    }
    
    fileprivate func prepareParameters() -> Dictionary<String,AnyObject>
    {
        var params = Dictionary<String,AnyObject>()
        switch data.type
        {
            case .creation: params["creation_id"] = data.bubbledObjectIdentifier as AnyObject?
            case .gallery:  params["gallery_id"] = data.bubbledObjectIdentifier as AnyObject?
            case .user:     params["user_id"] = data.bubbledObjectIdentifier as AnyObject?
        }
        if let color = data.colorName
        {
            params["color"] = color as AnyObject?
        }
        if let xPos = data.xPosition
        {
            params["x_pos"] = xPos as AnyObject?
        }
        if let yPos = data.yPosition
        {
            params["y_pos"] = yPos as AnyObject?
        }
        return params
    }
}
