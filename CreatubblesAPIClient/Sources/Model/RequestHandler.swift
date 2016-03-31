//
//  RequestHandler.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 31.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import Alamofire

@objc
public class RequestHandler: NSObject
{
    private let request: Alamofire.Request
    
    init(request: Alamofire.Request)
    {
        self.request = request
    }
    
    public func cancel()
    {
        request.cancel()
    }
}
