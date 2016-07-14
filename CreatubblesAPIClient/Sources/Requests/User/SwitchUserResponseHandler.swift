//
//  SwitchUserResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 12.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class SwitchUserResponseHandler: ResponseHandler
{
    private let completion: SwitchUserClosure?
    
    init(completion: SwitchUserClosure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(response: Dictionary<String, AnyObject>?, error: ErrorType?)
    {
        if  let response = response,
            let accessToken = response["access_token"] as? String {
            executeOnMainQueue { self.completion?(accessToken, ErrorTransformer.errorFromResponse(response, error: ErrorTransformer.errorFromResponse(response, error: error))) }
        } else {
            executeOnMainQueue { self.completion?(nil, ErrorTransformer.errorFromResponse(response, error: ErrorTransformer.errorFromResponse(response, error: error))) }
        }
    }
}