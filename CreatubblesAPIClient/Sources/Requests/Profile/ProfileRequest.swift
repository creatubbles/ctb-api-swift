//
//  ProfileRequest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 09.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class ProfileRequest: Request
{
    override var method: RequestMethod   { return .GET }
    override var endpoint: String
    {
        let user = userId != nil ? userId! : "me"
        return "users/"+user
    }

    override var parameters: Dictionary<String, AnyObject>
    {
        return Dictionary<String, AnyObject>()
    }
    
    private let userId: String?
    init(userId: String? = nil)
    {
        self.userId = userId
    }
}
