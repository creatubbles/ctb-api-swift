//
//  UserAccountDetailsRequest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 21.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class UserAccountDetailsRequest: Request
{
    override var method: RequestMethod { return .get }
    override var parameters: Dictionary<String, AnyObject> { return Dictionary<String, AnyObject>() }
    override var endpoint: String  { return "users/\(userId)/account" }
    
    fileprivate let userId: String
    
    init(userId: String)
    {
        self.userId = userId
    }
}
