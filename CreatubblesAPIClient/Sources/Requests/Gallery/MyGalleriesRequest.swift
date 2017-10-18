//
//  MyGalleriesRequest.swift
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

public enum GalleriesRequestFilter {
    case owned
    case shared
}

class MyGalleriesRequest: Request {
    override var method: RequestMethod { return .get }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    override var endpoint: String { return "users/me/galleries" }

    fileprivate let page: Int?
    fileprivate let perPage: Int?
    fileprivate let filter: GalleriesRequestFilter?

    init(page: Int?, perPage: Int?, filter: GalleriesRequestFilter?) {
        self.page = page
        self.perPage = perPage
        self.filter = filter
    }

    fileprivate func prepareParameters() -> Dictionary<String, AnyObject> {
        var params = Dictionary<String, AnyObject>()
        if let page = page {
            params["page"] = page as AnyObject?
        }

        if let perPage = perPage {
            params["per_page"] = perPage as AnyObject?
        }

        if filter == GalleriesRequestFilter.owned {
            params["gallery_filter"] = "only_owned" as AnyObject?
        }
        if filter == GalleriesRequestFilter.shared {
            params["gallery_filter"] = "only_shared" as AnyObject?
        }
        
        return params
    }
}
