//
//  NewCreationPingResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 17.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class NewCreationPingResponseHandler: ResponseHandler
{
    private let completion: (error:ErrorType?) -> Void
    
    init(completion: (error:ErrorType?) -> Void)
    {
        self.completion = completion
    }
    
    override func handleResponse(response: Dictionary<String, AnyObject>?, error: ErrorType?)
    {
        completion(error: error)
    }
}
