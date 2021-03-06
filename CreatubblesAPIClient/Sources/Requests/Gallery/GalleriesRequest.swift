//
//  GalleriesRequest.swift
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

import UIKit

class GalleriesRequest: Request {
    override var method: RequestMethod { return .get }
    override var parameters: Dictionary<String, AnyObject> { return prepareParametersDict() }
    override var endpoint: String {
        if let id = galleryId { return "galleries/"+id }
        if let id = userId { return "users/\(id)/galleries" }
        if let id = creationId { return "creations/\(id)/galleries" }
        if let id = partnerApplicationId { return "partner_applications/\(id)/galleries" }
        return "galleries"
    }

    fileprivate let galleryId: String?
    fileprivate let userId: String?
    fileprivate let creationId: String?
    fileprivate let partnerApplicationId: String?
    
    fileprivate let page: Int?
    fileprivate let perPage: Int?
    fileprivate let sort: SortOrder?
    fileprivate let query: String?
    fileprivate let filter: GalleriesRequestFilter?

    init(partnerApplicationId: String, pagingData: PagingData) {
        self.galleryId = nil
        self.page = pagingData.page
        self.perPage = pagingData.pageSize
        self.sort = nil
        self.creationId = nil
        self.userId = nil
        self.query = nil
        self.filter = nil
        self.partnerApplicationId = partnerApplicationId
    }
    
    init(galleryId: String) {
        self.galleryId = galleryId
        self.page = nil
        self.perPage = nil
        self.sort = nil
        self.creationId = nil
        self.userId = nil
        self.query = nil
        self.filter = nil
        self.partnerApplicationId = nil
    }

    init(page: Int?, perPage: Int?, sort: SortOrder?, filter: GalleriesRequestFilter?, userId: String?, query: String?) {
        self.galleryId = nil
        self.page = page
        self.perPage = perPage
        self.sort = sort
        self.creationId = nil
        self.userId = userId
        self.query = query
        self.filter = filter
        self.partnerApplicationId = nil
    }

    init(creationId: String, page: Int?, perPage: Int?, sort: SortOrder?, filter: GalleriesRequestFilter?) {
        self.galleryId = nil
        self.page = page
        self.perPage = perPage
        self.sort = sort
        self.creationId = creationId
        self.filter = filter
        self.userId = nil
        self.query = nil
        self.partnerApplicationId = nil
    }

    fileprivate func prepareParametersDict() -> Dictionary<String, AnyObject> {
        if let _ = galleryId {
            return Dictionary<String, AnyObject>()
        } else {
            var dict = Dictionary<String, AnyObject>()
            if let page = page {
                dict["page"] = page as AnyObject?
            }
            if let perPage = perPage {
                dict["per_page"] = perPage as AnyObject?
            }
            if let sort = sort {
                dict["sort"] = Request.sortOrderStringValue(sort) as AnyObject?
            }
            if let query = query {
                dict["query"] = query as AnyObject?
            }
            if filter == GalleriesRequestFilter.owned {
                dict["filter[only_owned]"] = "true" as AnyObject    //has to be sent as string
            }
            if filter == GalleriesRequestFilter.shared {
                dict["filter[only_shared]"] = "true" as AnyObject   //has to be sent as string
            }
            
            return dict
        }
    }
}
