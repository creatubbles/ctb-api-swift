//
//  MyConnectionsRequest.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 04.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class MyConnectionsRequest: Request
{
    override var method: RequestMethod  { return .GET }
//    override var endpoint: String       { return "users/me/connected_users" }
    override var endpoint: String
    {
        let user = userId != nil ? userId! : "me"
        return "users/"+user+"/connected_users"
    }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    
    private let page: Int?
    private let perPage: Int?
    
    private let userId: String?
    
    init(page: Int? = nil, perPage: Int? = nil, userId: String? = nil)
    {
        self.page = page
        self.perPage = perPage
        self.userId = userId
    }
    
    private func prepareParameters() -> Dictionary<String, AnyObject>
    {
        var params = Dictionary<String, AnyObject>()
        
        if let page = page
        {
            params["page"] = page
        }
        if let perPage = perPage
        {
            params["per_page"] = perPage
        }
        if let userId = userId
        {
            params["user_id"] = userId
        }
        return params
    }
    
}
