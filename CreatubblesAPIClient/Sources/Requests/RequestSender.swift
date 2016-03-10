//
//  RequestSender.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2016 Creatubbles Pte. Ltd.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit
import Alamofire
import p2_OAuth2


class RequestSender: NSObject
{
    private let settings: CreatubblesAPIClientSettings
    private let oauth2PrivateClient: OAuth2PasswordGrant
    private let oauth2PublicClient: OAuth2ImplicitGrant
    private var oauth2: OAuth2
    {
        return oauth2PrivateClient.hasUnexpiredAccessToken() ? oauth2PrivateClient : oauth2PublicClient
    }
    
    init(settings: CreatubblesAPIClientSettings)
    {
        self.settings = settings
        self.oauth2PrivateClient = RequestSender.prepareOauthPrivateClient(settings)
        self.oauth2PublicClient = RequestSender.prepareOauthPublicClient(settings)
        super.init()
    }
    
    private static func prepareOauthPrivateClient(settings: CreatubblesAPIClientSettings) -> OAuth2PasswordGrant
    {
        let oauthSettings =
        [
            "client_id": settings.appId,
            "client_secret": settings.appSecret,
            "authorize_uri": settings.authorizeUri,
            "token_uri":     settings.tokenUri,
        ] as OAuth2JSON
        
        let client = OAuth2PasswordGrant(settings: oauthSettings)
        client.verbose = false
        return client
    }
    
    private static func prepareOauthPublicClient(settings: CreatubblesAPIClientSettings) -> OAuth2ImplicitGrant
    {
        let oauthSettings =
        [
            "client_id": settings.appId,
            "client_secret": settings.appSecret,
            "authorize_uri": settings.authorizeUri,
            "token_uri":     settings.tokenUri,
            ] as OAuth2JSON
        
        let client = OAuth2ImplicitGrant(settings: oauthSettings)
        client.verbose = false
        return client
    }
    
    //MARK: - Authentication
    
    var authenticationToken: String? { return oauth2PrivateClient.accessToken }
    func login(username: String, password: String, completion: ErrorClousure?)
    {

        oauth2PrivateClient.username = username
        oauth2PrivateClient.password = password
        oauth2PrivateClient.onAuthorize =
        {
            [weak self](parameters: OAuth2JSON) -> Void in
            if let weakSelf = self
            {
                weakSelf.oauth2PrivateClient.onAuthorize = nil
            }
            Logger.log.debug("User logged in successfully")
            completion?(nil)
        }        
        oauth2PrivateClient.onFailure =
        {
            [weak self](error: ErrorType?) -> Void in
            if let weakSelf = self
            {
                weakSelf.oauth2PrivateClient.onFailure = nil
            }
            Logger.log.error("Error while login:\(error)")
            
            let err = error as! OAuth2Error
            completion?(CreatubblesAPIClientError.Generic(err.description))
        }
        oauth2PrivateClient.authorize()
    }
    
    func logout()
    {        
        oauth2PrivateClient.forgetTokens()
    }
    
    func isLoggedIn() -> Bool
    {
        return oauth2PrivateClient.hasUnexpiredAccessToken()
    }
    
    //MARK: - Request sending
    func send(request: Request, withResponseHandler handler: ResponseHandler)
    {
        Logger.log.debug("Sending request: \(request.dynamicType)")
        oauth2.request(alamofireMethod(request.method), urlStringWithRequest(request), parameters:request.parameters)
        .responseString
        {
            (response) -> Void in
            if let err = response.result.error
            {
                Logger.log.error("Error while sending request:\(request.dynamicType) \nError:\n \(err) \nResponse:\n \(response.result.value)")
            }
        }
        .responseJSON
        {
            response -> Void in
            handler.handleResponse((response.result.value as? Dictionary<String, AnyObject>),error: response.result.error)
        }
    }
    
    //MARK: - Creation sending
    func send(data: NSData, uploadData: CreationUpload, progressChanged: (bytesWritten: Int, totalBytesWritten: Int, totalBytesExpectedToWrite: Int) -> Void, completion: (error: ErrorType?) -> Void)
    {
        Logger.log.debug("Uploading data with identifier:\(uploadData.identifier) to:\(uploadData.uploadUrl)")
        Alamofire.upload(.PUT, uploadData.uploadUrl, headers: ["Content-Type":uploadData.contentType], data: data)
        .progress(
        {
            (written, totalWritten, totalExpected) -> Void in
            Logger.log.verbose("Uploading progress for data with identifier:\(uploadData.identifier) \n \(totalWritten)/\(totalExpected)")
            
            progressChanged(bytesWritten: Int(written), totalBytesWritten: Int(totalWritten), totalBytesExpectedToWrite: Int(totalExpected))
        })
        .responseString(completionHandler: { (response) -> Void in
            Logger.log.verbose("Uploading finished for data with identifier:\(uploadData.identifier)")
            completion(error: response.result.error)
        })
    }
    
    //MARK: - Utils
    private func urlStringWithRequest(request: Request) -> String
    {
        return String(format: "%@/%@/%@", arguments: [settings.baseUrl, settings.apiVersion, request.endpoint])
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
