//
//  FetchGalleriesRequest.swift
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

import Foundation

class FetchCreationsRequest: Request {
    override var method: RequestMethod { return .get }
    override var endpoint: String {
        if let creationId = creationId {
            return "creations/"+creationId
        }
        if let recommendedUserId = recommendedUserId {
            return "users/\(recommendedUserId)/recommended_creations"
        }
        if let recommendedCreationId = recommendedCreationId {
            return "creations/\(recommendedCreationId)/recommended_creations"
        }
        if let partnerApplicationId = partnerApplicationId {
            return "partner_applications/\(partnerApplicationId)/creations"
        }
        //when listed by: user, submitted to gallery, recent, by name and only public should return "creations"
        return "creations"
    }

    override var parameters: Dictionary<String, AnyObject> { return prepareParametersDictionary() }

    fileprivate let page: Int?
    fileprivate let perPage: Int?
    fileprivate let galleryId: String?
    fileprivate let userId: String?
    fileprivate let sort: SortOrder?
    fileprivate let keyword: String?
    fileprivate let onlyPublic: Bool

    fileprivate let creationId: String?
    fileprivate let recommendedCreationId: String?
    fileprivate let recommendedUserId: String?
    fileprivate let partnerApplicationId: String?

    init(page: Int?, perPage: Int?, galleryId: String?, userId: String?, sort: SortOrder?, keyword: String?, partnerApplicationId: String? = nil, onlyPublic: Bool) {
        self.page = page
        self.perPage = perPage
        self.galleryId = galleryId
        self.userId = userId
        self.sort = sort
        self.keyword = keyword
        self.onlyPublic = onlyPublic
        self.creationId = nil
        self.recommendedUserId = nil
        self.recommendedCreationId = nil
        self.partnerApplicationId = partnerApplicationId
    }

    init(creationId: String) {
        self.page = nil
        self.perPage = nil
        self.galleryId = nil
        self.userId = nil
        self.sort = nil
        self.keyword = nil
        self.onlyPublic = false // this is the case when a single creation is returned, so onlyPublic value is irrelevant
        self.creationId = creationId
        self.recommendedUserId = nil
        self.recommendedCreationId = nil
        self.partnerApplicationId = nil
    }
    
    init(partnerApplicationId: String, pagingData: PagingData) {
        self.page = pagingData.page
        self.perPage = pagingData.pageSize
        self.galleryId = nil
        self.userId = nil
        self.sort = nil
        self.keyword = nil
        self.onlyPublic = false // this is the case when a single creation is returned, so onlyPublic value is irrelevant
        self.creationId = nil
        self.recommendedUserId = nil
        self.recommendedCreationId = nil
        self.partnerApplicationId = partnerApplicationId
    }

    init(page: Int?, perPage: Int?, recommendedCreationId: String) {
        self.page = page
        self.perPage = perPage
        self.galleryId = nil
        self.userId = nil
        self.sort = nil
        self.keyword = nil
        self.onlyPublic = true
        self.creationId = nil
        self.recommendedUserId = nil
        self.recommendedCreationId = recommendedCreationId
        self.partnerApplicationId = nil
    }

    init(page: Int?, perPage: Int?, recommendedUserId: String) {
        self.page = page
        self.perPage = perPage
        self.galleryId = nil
        self.userId = nil
        self.sort = nil
        self.keyword = nil
        self.onlyPublic = true
        self.creationId = nil
        self.recommendedUserId = recommendedUserId
        self.recommendedCreationId = nil
        self.partnerApplicationId = nil
    }

    func prepareParametersDictionary() -> Dictionary<String, AnyObject> {
        var params = Dictionary<String, AnyObject>()

        if let page = page {
            params["page"] = page as AnyObject?
        }
        if let perPage = perPage {
            params["per_page"] = perPage as AnyObject?
        }
        if let galleryId = galleryId {
            params["gallery_id"] = galleryId as AnyObject?
        }
        if let userId = userId {
            params["user_id"] = userId as AnyObject?
        }
        if let sort = sort {
            params["sort"] = Request.sortOrderStringValue(sort) as AnyObject?
        }
        if onlyPublic {
            params["only_public"] = onlyPublic as AnyObject?
        }
        if let keyword = keyword {
            params["search"] = keyword as AnyObject?
        }
        if let partnerApplicationId = partnerApplicationId as AnyObject? {
            params["partner_application_id"] = partnerApplicationId
        }
        return params
    }
}
