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
    private let apiVersion = "v2"

    private let settings: CreatubblesAPIClientSettings
    
    init(settings: CreatubblesAPIClientSettings)
    {
        self.settings = settings
        super.init()
    }
    
    
    func send(request: Request, withResponseHandler handler: ResponseHandler)
    {
        Alamofire.request(alamofireMethod(request.method), urlStringWithRequest(request), parameters:request.parameters)
        .responseString(completionHandler:
        {
            (response: Response<String, NSError>) -> Void in
            print(response)
        })
        .responseJSON
        {
            response -> Void in
            handler.handleResponse((response.result.value as? Dictionary<String, AnyObject>),error: response.result.error)
        }
    }
    
    //MARK: - Utils
    private func urlStringWithRequest(request: Request) -> String
    {
        return String(format: "%@/%@/%@/%@", arguments: [baseUrl, apiPrefix, apiVersion, request.endpoint])
    }
    
    private func alamofireMethod(method: RequestMethod) -> Alamofire.Method
    {
        switch method
        {
            case .OPTIONS:  return .OPTIONS
            case .GET:      return .GET
            case .HEAD:     return .HEAD
            case .POST:     return .POST
            case .PUT:      return .PUT
            case .PATCH:    return .PATCH
            case .DELETE:   return .DELETE
            case .TRACE:    return .TRACE
            case .CONNECT:  return .CONNECT
        }
    }
    
}
