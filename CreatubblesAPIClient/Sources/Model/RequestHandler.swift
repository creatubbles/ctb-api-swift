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
public class RequestHandler: NSObject, Cancelable
{
    private let object: Cancelable
    
    init(object: Cancelable)
    {
        self.object = object
    }
    
    public func cancel()
    {
        object.cancel()
    }
}
