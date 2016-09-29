//
//  PartnerApplicationsSearchRequest.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 04.08.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class PartnerApplicationsSearchRequest: Request
{
    override var method: RequestMethod   { return .get }
    override var endpoint: String        { return "partner_applications" }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    
    fileprivate let query: String
    
    init(query: String)
    {
        self.query = query
    }
    
    func prepareParameters() -> Dictionary<String, AnyObject>
    {
        var params = Dictionary<String, AnyObject>()
        
        params["query"] = query as AnyObject?
        return params
    }
    
}
