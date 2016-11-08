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
    fileprivate let completion: ErrorClosure?
    
    init(completion: ErrorClosure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(_ response: Dictionary<String, AnyObject>?, error: Error?)
    {
        executeOnMainQueue { self.completion?( ErrorTransformer.errorFromResponse(response, error: error)) }
    }
}
