//
//  BubblesFetchReqest.swift
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

class BubblesFetchReqest: Request {
    override var method: RequestMethod { return .get }
    override var parameters: Dictionary<String, AnyObject> { return prepareParametersDictionary() }
    override var endpoint: String {
        if let creationId = creationId {
            return "creations/\(creationId)/bubbles"
        }
        if let galleryId = galleryId {
            return "galleries/\(galleryId)/bubbles"
        }
        if let userId = userId {
            return "users/\(userId)/bubbles"
        }
        return ""
    }

    fileprivate let creationId: String?
    fileprivate let galleryId: String?
    fileprivate let userId: String?
    fileprivate let page: Int?
    fileprivate let perPage: Int?

    init(creationId: String, page: Int?, perPage: Int?) {
        self.creationId = creationId
        self.page = page

        self.perPage = perPage
        self.galleryId = nil
        self.userId = nil
    }

    init(galleryId: String, page: Int?, perPage: Int?) {
        self.page = page
        self.perPage = perPage

        self.creationId = nil
        self.galleryId = galleryId
        self.userId = nil
    }

    init(userId: String, page: Int?, perPage: Int?) {
        self.page = page
        self.perPage = perPage

        self.creationId = nil
        self.galleryId = nil
        self.userId = userId
    }

    func prepareParametersDictionary() -> Dictionary<String, AnyObject> {
        var params = Dictionary<String, AnyObject>()

        if let page = page {
            params["page"] = page as AnyObject?
        }
        if let perPage = perPage {
            params["per_page"] = perPage as AnyObject?
        }
        return params
    }
}
