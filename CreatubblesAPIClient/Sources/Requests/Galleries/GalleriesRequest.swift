//
//  GalleriesRequest.swift
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

class GalleriesRequest: Request
{
    override var method: RequestMethod   { return .GET }
    override var parameters: Dictionary<String, AnyObject> { return prepareParametersDict() }
    override var endpoint: String
    {
        if let galleryId = galleryId
        {
            return "galleries/"+galleryId
        }
        return "galleries"
    }
    
    private let galleryId: String?
    private let page: Int?
    private let perPage: Int?
    private let sort: SortOrder?
    private let userId: String?
    
    init(galleryId: String)
    {
        self.galleryId = galleryId
        self.page = nil
        self.perPage = nil
        self.sort = nil
        self.userId = nil
    }
    
    init(page: Int?, perPage: Int?, sort: SortOrder?, userId: String?)
    {
        self.galleryId = nil
        self.page = page
        self.perPage = perPage
        self.sort = sort
        self.userId = userId
    }
    
    private func prepareParametersDict() -> Dictionary<String, AnyObject>
    {
        if let _ = galleryId
        {
            return Dictionary<String, AnyObject>()
        }
        else
        {
            var dict = Dictionary<String, AnyObject>()
            if let page = page
            {
                dict["page"] = page
            }
            if let perPage = perPage
            {
                dict["per_page"] = perPage
            }
            if let sort = sort
            {
                dict["sort"] = Request.sortOrderStringValue(sort)
            }
            if let userId = userId
            {
                dict["user_id"] = userId
            }
            return dict
        }
    }
}
