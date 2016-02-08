//
//  RequestSender.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 04.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import Alamofire

class RequestSender: NSObject
{
    private let baseUrl = "https://staging.creatubbles.com"
    private let apiPrefix = "api"
    private let apiVersion = "V2"
    private let basicAuthenticationUser = "BASIC_USER"
    private let basicAuthenticationPassword = "BASIC_PASS"
    
    private let settings: CreatubblesAPIClientSettings
    
    init(settings: CreatubblesAPIClientSettings)
    {
        self.settings = settings
        super.init()
    }
    
    
    func send(request: Request, withResponseHandler handler: ResponseHandler)
    {
        Alamofire.request(.GET, urlStringWithRequest(request), parameters:request.parameters)
        .authenticate(user: basicAuthenticationUser, password: basicAuthenticationPassword)
        .responseJSON
        {
            response -> Void in
            handler.handleResponse(response.result.value as! Dictionary<String, AnyObject>,error: response.result.error)
        }
    }
    
    //MARK: - Utils
    private func urlStringWithRequest(request: Request) -> String
    {
        return String(format: "%@/%@/%@/%@", arguments: [baseUrl, apiPrefix, apiVersion, request.endpoint])
    }
    
    
}
