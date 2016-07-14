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
    override var method: RequestMethod  { return .POST }
    override var endpoint: String       { return "creator_builder_jobs" }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    
    private let amount: Int
    private let birthYear: Int
    private let groupName: String?

    init(amount: Int, birthYear:Int, groupName: String?)
    {
        self.amount = amount
        self.birthYear = birthYear
        self.groupName = groupName
    }

    private func prepareParameters() -> Dictionary<String, AnyObject>
    {
        var params = Dictionary<String, AnyObject>()
        
        params["amount"] = amount
        params["birth_year"] = birthYear
        
        if let groupName = groupName
        {
            params["group"] = groupName
        }
        
        return params
    }
}
