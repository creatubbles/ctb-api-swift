//
//  TestComponentsFactory.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 10.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
@testable import CreatubblesAPIClient

class TestComponentsFactory: NSObject
{
    private static let useMockSender = true
    private static let settings = TestConfiguration.settings
    
    static var requestSender: RequestSender
    {
        if(useMockSender)
        {
            return TestRequestSender(settings: settings)
        }
        else
        {
            return RequestSender(settings: settings)
        }
    }
}
