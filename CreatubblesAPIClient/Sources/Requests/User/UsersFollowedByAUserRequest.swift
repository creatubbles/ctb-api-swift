//
//  UsersFollowedByAUserRequest.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 20.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class UsersFollowedByAUserRequest: Request
{
    override var method: RequestMethod  { return .get }
    override var endpoint: String
    {
        let user = userId
        return "users/"+user+"/followed_users"
    }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    
    fileprivate let page: Int?
    fileprivate let perPage: Int?
    fileprivate let userId: String
    
    init(page: Int? = nil, perPage: Int? = nil, userId: String)
    {
        self.page = page
        self.perPage = perPage
        self.userId = userId
    }
    
    fileprivate func prepareParameters() -> Dictionary<String, AnyObject>
    {
        var params = Dictionary<String, AnyObject>()
        
        if let page = page
        {
            params["page"] = page as AnyObject?
        }
        if let perPage = perPage
        {
            params["per_page"] = perPage as AnyObject?
        }
            params["user_id"] = userId as AnyObject?
        
        return params
    }

}
