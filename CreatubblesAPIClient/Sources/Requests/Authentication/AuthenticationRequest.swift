//
//  AuthenticationRequest.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 26.10.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class AuthenticationRequest: Request {
    override var method: RequestMethod  { return .post }
    override var endpoint: String { return settings.tokenUri }
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
        
        params["grant_type"] = "password" as AnyObject?
        params["client_id"] = settings.appId as AnyObject?
        params["client_secret"] = settings.appSecret as AnyObject?
        
        return params
    }
}
