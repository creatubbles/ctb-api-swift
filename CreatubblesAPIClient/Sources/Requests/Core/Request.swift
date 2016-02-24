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
    case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
}

class Request: NSObject
{
    var method: RequestMethod   { return .GET }
    var endpoint: String        { return ""   }
    var parameters: Dictionary<String, AnyObject> { return Dictionary<String, AnyObject>() }
    
    class func sortOrderStringValue(sortOrder: SortOrder) -> String
    {
        switch sortOrder
        {
            case .Popular:  return "popular"
            case .Recent:   return "recent"
        }
    }
}