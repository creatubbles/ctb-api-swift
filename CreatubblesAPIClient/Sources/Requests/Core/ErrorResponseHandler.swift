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
    private let completion: ErrorClousure?
    
    init(completion: ErrorClousure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(response: Dictionary<String, AnyObject>?, error: ErrorType?)
    {
        completion?( ErrorTransformer.errorFromResponse(response, error: error))
    }
}
