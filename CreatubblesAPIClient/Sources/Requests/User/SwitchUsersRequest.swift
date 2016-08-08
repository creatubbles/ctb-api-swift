//
//  SwitchUsersRequest.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 08.08.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class SwitchUsersRequest: Request {
    override var method: RequestMethod  { return .GET }
    override var endpoint: String       { return "user_switch/users" }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    
    private let page: Int?
    private let perPage: Int?
    
    init(page: Int? = nil, perPage: Int? = nil) {
        self.page = page
        self.perPage = perPage
    }
    
    private func prepareParameters() -> Dictionary<String, AnyObject> {
        var params = Dictionary<String, AnyObject>()
        
        if let page = page {
            params["page"] = page
        }
        
        if let perPage = perPage {
            params["per_page"] = perPage
        }
        
        return params
    }
    
}