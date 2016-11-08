//
//  GroupsRequest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 30.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class GroupsRequest: Request
{
    override var method: RequestMethod   { return .get }
    override var parameters: Dictionary<String, AnyObject> { return Dictionary<String, AnyObject>() }
    override var endpoint: String
    {
        if let identifier = identifier { return "groups/\(identifier)"}
        return "groups"
    }
    
    let identifier: String?
    
    init(groupId: String? = nil)
    {
        identifier = groupId
    }
}
