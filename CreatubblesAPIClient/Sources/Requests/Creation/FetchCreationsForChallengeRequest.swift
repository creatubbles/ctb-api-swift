//
//  FetchCreationsForChallengeRequest.swift
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

class FetchCreationsForChallengeRequest: Request {
    override var method: RequestMethod { return .get }
    override var endpoint: String {
        return "v3/creations"
    }
    override var useExternalNamespace: Bool { return true }
    
    override var parameters: Dictionary<String, AnyObject> { return prepareParametersDictionary() }
    
    fileprivate let page: Int?
    fileprivate let perPage: Int?
    fileprivate let challengeId: String?
    fileprivate let sort: SortMethod?
    
    init(page: Int?, perPage: Int?, challengeId: String?, sort: SortMethod?) {
        self.page = page
        self.perPage = perPage
        self.challengeId = challengeId
        self.sort = sort
    }
    
    func prepareParametersDictionary() -> Dictionary<String, AnyObject> {
        var params = Dictionary<String, AnyObject>()
        
        if let page = page {
            params["page"] = page as AnyObject?
        }
        if let perPage = perPage {
            params["per_page"] = perPage as AnyObject?
        }
        if let challengeId = challengeId {
            params["filter[gallery_ids][]"] = challengeId as AnyObject?
        }
        if let sort = sort {
            params["sort"] = sort.rawValue as AnyObject?
        }
        return params
    }
}
