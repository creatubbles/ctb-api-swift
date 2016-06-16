//
//  TestRequestHandler.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 31.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@testable import CreatubblesAPIClient

class TestCancelable: Cancelable
{
    func cancel()
    {
        //Ignore
    }
}

class TestRequestHandler: RequestHandler
{
    init()
    {
        super.init(object: TestCancelable())
    }
}
