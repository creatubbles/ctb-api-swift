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
    private let completion: (response: Dictionary<String, AnyObject>?, error:ErrorType?) -> Void
    
    init(completion: (response: Dictionary<String, AnyObject>?, error:ErrorType?) -> Void)
    {
        self.completion = completion
        
    }
    
    override func handleResponse(response: Dictionary<String, AnyObject>?, error: ErrorType?)
    {
        completion(response: response, error: error)
    }
    
}
