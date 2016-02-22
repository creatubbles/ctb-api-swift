//
//  CreatorsAndManagersRequest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 09.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

enum CreatorsAndManagersScopeElement: String
{
    case Managers = "managers"
    case Creators = "creators"
}

class CreatorsAndManagersRequest: Request
{
    override var method: RequestMethod  { return .GET }
    override var endpoint: String       { return "users" }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    
    private let userId: String?
    private let page: Int?
    private let perPage: Int?
    private let scope: CreatorsAndManagersScopeElement?
    
    init(userId: String? = nil, page: Int? = nil, perPage: Int? = nil, scope:CreatorsAndManagersScopeElement? = nil)
    {
        self.userId = userId
        self.page = page
        self.perPage = perPage
        self.scope = scope
    }
    
    private func prepareParameters() -> Dictionary<String, AnyObject>
    {
        var params = Dictionary<String, AnyObject>()
        
        if let userId = userId
        {
            params["user_id"] = userId
        }
        if let page = page
        {
            params["page"] = page
        }
        if let perPage = perPage
        {
            params["per_page"] = perPage
        }
        if let scope = scope
        {
            params["scope"] = scope.rawValue
        }
        
        return params
    }

}
