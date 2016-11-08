//
//  NotificationsFetchRequest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 05.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class NotificationsFetchRequest: Request
{
    override var method: RequestMethod  { return .get }
    override var endpoint: String       { return "notifications" }
    override var parameters: Dictionary<String, AnyObject> { return prepareParams() }
    
    fileprivate let page: Int?
    fileprivate let perPage: Int?
    
    init(page: Int? = nil, perPage: Int? = nil)
    {
        self.page = page
        self.perPage = perPage
    }
    
    func prepareParams() -> Dictionary<String, AnyObject>
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
        
        return params
    }
}
