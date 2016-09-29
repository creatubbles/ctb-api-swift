//
//  NewCreationRequest.swift
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

import UIKit

class NewCreationRequest: Request
{
    override var method: RequestMethod  { return .post }
    override var endpoint: String       { return "creations" }
    override var parameters: Dictionary<String, AnyObject> { return prepareParams() }

    fileprivate let creationData: NewCreationData
    
    
    override init()
    {
        self.creationData = NewCreationData(image: UIImage(), uploadExtension: .jpeg)
    }
    
    init(creationData: NewCreationData)
    {
        self.creationData = creationData
    }
    
    fileprivate func prepareParams() -> Dictionary<String, AnyObject>
    {
        var params = Dictionary<String, AnyObject>()
        if let name = creationData.name
        {
            params["name"] = name as AnyObject?
        }
        if let creatorIds = creationData.creatorIds
        {
            params["creator_ids"] = creatorIds.joined(separator: ",") as AnyObject?
        }
        if let creationMonth = creationData.creationMonth
        {
            params["created_at_month"] = creationMonth as AnyObject?
        }
        if let creationYear = creationData.creationYear
        {
            params["created_at_year"] = creationYear as AnyObject?
        }
        if let reflectionText = creationData.reflectionText
        {
            params["reflection_text"] = reflectionText as AnyObject?
        }
        if let reflectionVideoUrl = creationData.reflectionVideoUrl
        {
            params["reflection_video_url"] = reflectionVideoUrl as AnyObject?
        }
        
        return params
    }
}
