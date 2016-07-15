//
//  DeleteGroupRequest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 14.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class DeleteGroupRequest: Request
{
    override var method: RequestMethod   { return .DELETE }
    override var parameters: Dictionary<String, AnyObject> { return Dictionary<String, AnyObject>() }
    override var endpoint: String { return "groups/\(identifier)" }
    
    private let identifier: String
    
    init(identifier: String)
    {
        self.identifier = identifier
    }
}
