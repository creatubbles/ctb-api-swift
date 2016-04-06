//
//  TestRequestHandler.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 31.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import Alamofire

@testable import CreatubblesAPIClient

class TestRequestHandler: RequestHandler
{
    init()
    {
        let request = Alamofire.request(.GET, "dummy.com")
        request.cancel()
        super.init(object: request)
    }
}
