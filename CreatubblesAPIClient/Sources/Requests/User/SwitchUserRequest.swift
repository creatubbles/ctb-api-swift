//
//  SwitchUserRequest.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 12.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class SwitchUserRequest: Request {
    
    override var method: RequestMethod { return .POST }
    override var endpoint: String      { return "oauth/token" }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    
    private let targetUserId: String?
    private let accessToken: String?
    
    init(targetUserId: String? = nil, accessToken: String? = nil) {
        self.targetUserId = targetUserId
        self.accessToken = accessToken
    }
    
    private func prepareParameters() -> Dictionary<String, AnyObject> {
        var params = Dictionary<String, AnyObject>()
        
        if let targetUserId = targetUserId {
            params["target_user_id"] = targetUserId
        }
        
        if let accessToken = accessToken {
            params["access_token"] = accessToken
        }
        
        params["grant_type"] = "user_switch"
        
        return params
    }
}
