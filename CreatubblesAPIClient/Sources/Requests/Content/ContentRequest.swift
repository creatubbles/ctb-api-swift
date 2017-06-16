//
//  ContentRequest.swift
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

enum ContentType: String {
    case Recent = "recent"
    case Trending = "trending"
    case BubbledContents = "bubbled_contents"
    case Connected = "connected"
    case ContentsByAUser = "contents"
    case Followed = "followed"
}

class ContentRequest: Request {
    override var parameters: Dictionary<String, AnyObject> { return prepareParametersDictionary() }
    override var method: RequestMethod { return .get }
    override var endpoint: String {
        if  type == .BubbledContents,
            let identifier = userId {
            return "users/\(identifier)/bubbled_contents"
        } else if type == .ContentsByAUser,
            let identifier = userId {
            return "users/\(identifier)/contents"
        }

        return "contents/"+type.rawValue
    }

    fileprivate let type: ContentType
    fileprivate let page: Int?
    fileprivate let perPage: Int?
    fileprivate let userId: String?

    init(type: ContentType, page: Int?, perPage: Int?, userId: String? = nil) {
        assert( (type == .BubbledContents && userId == nil) == false, "userId cannot be nil for BubbledContents")
        self.type = type
        self.page = page
        self.perPage = perPage
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
