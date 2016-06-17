//
//  ErrorResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 17.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class ErrorResponseHandler: ResponseHandler
{
    private let completion: ErrorClosure?
    
    init(completion: ErrorClosure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(response: Dictionary<String, AnyObject>?, error: ErrorType?)
    {
        executeOnMainQueue { self.completion?( ErrorTransformer.errorFromResponse(response, error: error)) }
    }
}
