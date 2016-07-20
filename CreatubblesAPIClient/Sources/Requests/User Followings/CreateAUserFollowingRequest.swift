//
//  CreateAUserFollowingRequest.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 20.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class CreateAUserFollowingRequest: Request
{
    override var method: RequestMethod  { return .POST }
    override var endpoint: String       { return "users/"+userId+"/following" }
    
    private let userId: String

    init(userId: String)
    {
        self.userId = userId
    }
}
