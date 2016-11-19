//
//  AuthenticationRequest.swift
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
//


import UIKit

class AuthenticationRequest: Request {
    override var method: RequestMethod  { return .post }
    override var endpoint: String { return settings.tokenUri }
    override var onlyPath: Bool { return false }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    
    fileprivate let settings: APIClientSettings
    fileprivate let username: String?
    fileprivate let password: String?
    
    init(username: String?, password: String?, settings: APIClientSettings) {
        self.username = username
        self.password = password
        self.settings = settings
    }
    
    fileprivate func prepareParameters() -> Dictionary<String,AnyObject> {
        var params = Dictionary<String,AnyObject>()
        if let username = username {
            params["username"] = username as AnyObject?
        }
        
        if let password = password {
            params["password"] = password as AnyObject?
        }
        
        if username != nil && password != nil {
            params["grant_type"] = "password" as AnyObject?
        } else {
            params["grant_type"] = "client_credentials" as AnyObject?
        }
        params["client_id"] = settings.appId as AnyObject?
        params["client_secret"] = settings.appSecret as AnyObject?
        
        return params
    }
}
