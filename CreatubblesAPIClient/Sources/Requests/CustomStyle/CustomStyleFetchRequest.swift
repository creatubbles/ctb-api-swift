//
//  CustomStyleFetchRequest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class CustomStyleFetchRequest: Request
{
    override var method: RequestMethod   { return .GET }
    override var endpoint: String        { return "users/\(userIdentifier)/custom_style" }
    override var parameters: Dictionary<String, AnyObject> { return Dictionary<String, AnyObject>() }
    
    private let userIdentifier: String
    init(userIdentifier: String)
    {
        self.userIdentifier = userIdentifier
    }
}
