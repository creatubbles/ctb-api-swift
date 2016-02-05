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
    private let baseUrl = "https://www.creatubbles.com"
    private let apiPrefix = "api"
    private let apiVersion = "V2"
    
    func send(request: Request, withResponseHandler handler: ResponseHandler)
    {
        Alamofire.request(.GET, urlStringWithRequest(request)).responseJSON
        {
            response -> Void in
            handler.handleResponse(response)
        }
    }
    
    private func urlStringWithRequest(request: Request) -> String
    {
        return String(format: "%@/%@/%@/%@", arguments: [baseUrl, apiPrefix, apiVersion, request.endpoint])
    }
}
