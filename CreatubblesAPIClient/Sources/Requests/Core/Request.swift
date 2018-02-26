//
//  Request.swift
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

public enum RequestMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

open class Request: NSObject, Cancelable {
    open var method: RequestMethod { return .get }
    open var endpoint: String { return "" }
    open var onlyPath: Bool { return true }
    //If set to true, public access token will be used even when user is logged in
    open var forcePublicAuthentication: Bool { return false }

    //If set to true, version infix won't be set in RequestSender
    open var useExternalNamespace: Bool { return false }

    open var parameters: Dictionary<String, AnyObject> { return Dictionary<String, AnyObject>() }
    open var headers: Dictionary<String, String> { return Dictionary<String, String>() }

    class func sortOrderStringValue(_ sortOrder: SortOrder) -> String {
        switch sortOrder {
            case .popular:  return "popular"
            case .recent:   return "recent"
        }
    }

    public func cancel() {

    }
}
