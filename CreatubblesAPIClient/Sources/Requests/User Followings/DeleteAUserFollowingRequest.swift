//
//  DeleteAUserFollowingRequest.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 20.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class DeleteAUserFollowingRequest: Request
{
    override var method: RequestMethod  { return .delete }
    override var endpoint: String       { return "users/"+userId+"/following" }
    
    fileprivate let userId: String
    
    init(userId: String)
    {
        self.userId = userId
    }
}
