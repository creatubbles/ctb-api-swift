//
//  Request.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 04.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

enum RequestMethod
{
    case GET
    case POST
    case PUT
}

class Request: NSObject
{
    var method: RequestMethod   { return .GET }
    var endpoint: String        { return ""   }
    var parameters: Dictionary<String, AnyObject> { return Dictionary<String, AnyObject>() }
}