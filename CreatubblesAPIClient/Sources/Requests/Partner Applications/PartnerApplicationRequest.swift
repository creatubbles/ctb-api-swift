//
//  PartnerApplicationsRequest.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 02.08.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class PartnerApplicationRequest: Request
{
    override var method: RequestMethod   { return .get }
    override var endpoint: String        { return "partner_applications/\(id)" }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    
    fileprivate let id: String
    
    init(id: String)
    {
        self.id = id
    }
    
    func prepareParameters() -> Dictionary<String, AnyObject>
    {
        var params = Dictionary<String, AnyObject>()

        params["id"] = id as AnyObject?
        return params
    }

}
