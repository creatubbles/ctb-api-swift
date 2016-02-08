//
//  TokenResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 08.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class TokenResponseHandler: ResponseHandler
{
    private let completion: (token: CTToken, error:NSError?) -> Void
    
    init(completion: (token:CTToken, error:NSError?) -> Void)
    {
        self.completion = completion
    }
    
    override func handleResponse(response: Dictionary<String, AnyObject>, error: NSError?)
    {
        print(response)
    }
}
