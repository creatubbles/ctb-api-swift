//
//  RequestSender.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 04.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import Alamofire
import p2_OAuth2


class RequestSender: NSObject
{
    private let settings: CreatubblesAPIClientSettings
    private let oauth2Client: OAuth2PasswordGrant
    
    
    init(settings: CreatubblesAPIClientSettings)
    {
        self.settings = settings
        self.oauth2Client = RequestSender.prepareOauthClient(settings)
        super.init()
    }
    
    private static func prepareOauthClient(settings: CreatubblesAPIClientSettings) -> OAuth2PasswordGrant
    {
        let oauthSettings =
        [
            "client_id": settings.appId,
            "client_secret": settings.appSecret,
            "authorize_uri": settings.authorizeUri,
            "token_uri":     settings.tokenUri,
        ] as OAuth2JSON
        
        let client = OAuth2PasswordGrant(settings: oauthSettings)
        client.verbose = true
        return client
    }
    
    //MARK: - Interface
    func login(username: String, password: String, completion: (ErrorType?) -> Void)
    {

        oauth2Client.username = username
        oauth2Client.password = password
        oauth2Client.onAuthorize =
        {
            [weak self](parameters: OAuth2JSON) -> Void in
            if let weakSelf = self
            {
                weakSelf.oauth2Client.onAuthorize = nil
            }
            completion(nil)
        }        
        oauth2Client.onFailure =
        {
            [weak self](error: ErrorType?) -> Void in
            if let weakSelf = self
            {
                weakSelf.oauth2Client.onFailure = nil
            }
            completion(error)
        }
        oauth2Client.authorize()
    }
    
    func logout()
    {
        oauth2Client.forgetClient()
        oauth2Client.forgetTokens()
    }
    
    func send(request: Request, withResponseHandler handler: ResponseHandler)
    {
        oauth2Client.request(alamofireMethod(request.method), urlStringWithRequest(request), parameters:request.parameters)
        .validate()
        .responseString(completionHandler:
        {
            (response: Response<String, NSError>) -> Void in
            print(response.result)
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
        return String(format: "%@/%@/%@/%@", arguments: [settings.baseUrl, settings.apiPrefix, settings.apiVersion, request.endpoint])
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
