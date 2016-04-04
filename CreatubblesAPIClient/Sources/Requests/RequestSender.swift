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
    private let uploadManager: Alamofire.Manager
    private let settings: APIClientSettings
    private let oauth2PrivateClient: OAuth2PasswordGrant
    private let oauth2PublicClient: OAuth2ImplicitGrant
    private var oauth2: OAuth2
    {
        return oauth2PrivateClient.hasUnexpiredAccessToken() ? oauth2PrivateClient : oauth2PublicClient
    }
    
    init(settings: APIClientSettings)
    {
        self.settings = settings
        self.oauth2PrivateClient = RequestSender.prepareOauthPrivateClient(settings)
        self.oauth2PublicClient  = RequestSender.prepareOauthPublicClient(settings)
        self.uploadManager       = RequestSender.prepareUploadManager(settings)
        super.init()
    }
    
    private static func prepareUploadManager(settings: APIClientSettings) -> Alamofire.Manager
    {
        if let identifier = settings.backgroundSessionConfigurationIdentifier
        {
            let configuration = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier(identifier)
            return Alamofire.Manager(configuration: configuration)
        }
        else
        {
            let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            return Alamofire.Manager(configuration: configuration)
        }
    }
    
    private static func prepareOauthPrivateClient(settings: APIClientSettings) -> OAuth2PasswordGrant
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
    
    private static func prepareOauthPublicClient(settings: APIClientSettings) -> OAuth2ImplicitGrant
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
    
    func login(username: String, password: String, completion: ErrorClosure?) -> RequestHandler
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
            completion?(APIClientError.Generic(err.description))
        }
        oauth2PrivateClient.authorize()
        return RequestHandler(object: oauth2PrivateClient)
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
    func send(request: Request, withResponseHandler handler: ResponseHandler) -> RequestHandler
    {
        Logger.log.debug("Sending request: \(request.dynamicType)")        
        let request = oauth2.request(alamofireMethod(request.method), urlStringWithRequest(request), parameters:request.parameters)
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
        return RequestHandler(object: request)
    }
    
    //MARK: - Creation sending
    
    func send(creationData: NewCreationData, uploadData: CreationUpload, progressChanged: (bytesWritten: Int, totalBytesWritten: Int, totalBytesExpectedToWrite: Int) -> Void, completion: (error: ErrorType?) -> Void)
    {
        if(creationData.dataType == .Image)
        {
            Logger.log.debug("Uploading data with identifier:\(uploadData.identifier) to:\(uploadData.uploadUrl)")
            Alamofire.upload(.PUT, uploadData.uploadUrl, headers:  ["Content-Type":uploadData.contentType], data: UIImagePNGRepresentation(creationData.image!)!)
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
        else if(creationData.dataType == .Url)
        {
            Logger.log.debug("Uploading data with identifier:\(uploadData.identifier) to:\(uploadData.uploadUrl)")
            Alamofire.upload(.PUT, uploadData.uploadUrl, headers: ["Content-Type":uploadData.contentType], file: creationData.url!)
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
        else if(creationData.dataType == .Data)
        {
            Logger.log.debug("Uploading data with identifier:\(uploadData.identifier) to:\(uploadData.uploadUrl)")
            Alamofire.upload(.PUT, uploadData.uploadUrl, headers: ["Content-Type":uploadData.contentType], data: creationData.data!)
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

    }
    
    func send(data: NSData, uploadData: CreationUpload, progressChanged: (bytesWritten: Int, totalBytesWritten: Int, totalBytesExpectedToWrite: Int) -> Void, completion: (error: ErrorType?) -> Void)
    {
        Logger.log.debug("Uploading data with identifier:\(uploadData.identifier) to:\(uploadData.uploadUrl)")
        uploadManager.upload(.PUT, uploadData.uploadUrl, headers: ["Content-Type":uploadData.contentType], data: data)
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
    //MARK: - Background session
    var backgroundCompletionHandler: (() -> Void)?
    {
        get
        {
            return uploadManager.backgroundCompletionHandler
        }
        set
        {
            uploadManager.backgroundCompletionHandler = newValue
        }
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
