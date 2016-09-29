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
open class RequestHandler: NSObject, Cancelable
{
    fileprivate let object: Cancelable
    
    init(object: Cancelable)
    {
        self.object = object
    }
    
    open func cancel()
    {
        object.cancel()
    }
}
