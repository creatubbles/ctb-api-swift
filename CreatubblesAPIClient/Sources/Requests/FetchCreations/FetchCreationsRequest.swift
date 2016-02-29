//
//  FetchGalleriesRequest.swift
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

class FetchCreationsRequest: Request
{
    override var method: RequestMethod  { return .GET }
    override var endpoint: String
    {
        if let creationId = creationId
        {
            return "creations/"+creationId
        }
        return "creations"
    }
    
    override var parameters: Dictionary<String, AnyObject> { return prepareParametersDictionary() }
    
    private let page: Int?
    private let perPage: Int?
    private let galleryId: String?
    private let userId: String?
    private let sort: SortOrder?
    private let keyword: String?
    private let creationId: String?
    
    init(page: Int?, perPage: Int?, galleryId: String?, userId: String?, sort: SortOrder?, keyword: String?)
    {
        self.page = page
        self.perPage = perPage
        self.galleryId = galleryId
        self.userId = userId
        self.sort = sort
        self.keyword = keyword
        self.creationId = nil
    }
    
    init(creationId: String)
    {
        self.page = nil
        self.perPage = nil
        self.galleryId = nil
        self.userId = nil
        self.sort = nil
        self.keyword = nil
        self.creationId = creationId
    }
    
    func prepareParametersDictionary() -> Dictionary<String, AnyObject>
    {
        var params = Dictionary<String, AnyObject>()
        
        if let page = page
        {
            params["page"] = page
        }
        if let perPage = perPage
        {
            params["per_page"] = perPage
        }
        if let galleryId = galleryId
        {
            params["gallery_id"] = galleryId
        }
        if let userId = userId
        {
            params["user_id"] = userId
        }
        if let sort = sort
        {
            params["sort"] = Request.sortOrderStringValue(sort)
        }
        if let keyword = keyword
        {
            params["search"] = keyword
        }
        return params
    }
}

