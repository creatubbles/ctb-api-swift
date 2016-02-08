//
//  DummyResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 08.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
@testable import CreatubblesAPIClient

class DummyResponseHandler: ResponseHandler
{
    private let completion: (response: Dictionary<String, AnyObject>, error:NSError?) -> Void
    
    init(completion: (response: Dictionary<String, AnyObject>, error:NSError?) -> Void)
    {
        self.completion = completion
    }
    
    override func handleResponse(response: Dictionary<String, AnyObject>, error: NSError?)
    {
        completion(response: response, error: error)
    }
    
}
