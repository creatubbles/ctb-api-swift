//
//  CreateMultipleCreatorsRequest.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 13.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class CreateMultipleCreatorsRequest: Request
{
    override var method: RequestMethod  { return .post }
    override var endpoint: String       { return "creator_builder_jobs" }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    
    fileprivate let amount: Int
    fileprivate let birthYear: Int
    fileprivate let groupName: String?

    init(amount: Int, birthYear:Int, groupName: String?)
    {
        self.amount = amount
        self.birthYear = birthYear
        self.groupName = groupName
    }

    fileprivate func prepareParameters() -> Dictionary<String, AnyObject>
    {
        var params = Dictionary<String, AnyObject>()
        
        params["amount"] = amount as AnyObject?
        params["birth_year"] = birthYear as AnyObject?
        
        if let groupName = groupName
        {
            params["group"] = groupName as AnyObject?
        }
        
        return params
    }
}
