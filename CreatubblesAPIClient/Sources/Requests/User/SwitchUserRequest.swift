//
//  SwitchUserRequest.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 12.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class SwitchUserRequest: Request {
    
    override var method: RequestMethod { return .post }
    override var endpoint: String      { return "oauth/token" }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    
    fileprivate let targetUserId: String?
    fileprivate let accessToken: String?
    
    init(targetUserId: String? = nil, accessToken: String? = nil) {
        self.targetUserId = targetUserId
        self.accessToken = accessToken
    }
    
    fileprivate func prepareParameters() -> Dictionary<String, AnyObject> {
        var params = Dictionary<String, AnyObject>()
        
        if let targetUserId = targetUserId {
            params["target_user_id"] = targetUserId as AnyObject?
        }
        
        if let accessToken = accessToken {
            params["access_token"] = accessToken as AnyObject?
        }
        
        params["grant_type"] = "user_switch" as AnyObject?
        
        return params
    }
}
