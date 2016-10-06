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
    fileprivate let uploadManager: Alamofire.SessionManager
    fileprivate var alamofireManager: SessionManager?
    fileprivate let settings: APIClientSettings
    fileprivate let oauth2PrivateClient: OAuth2PasswordGrant
    fileprivate let oauth2PublicClient: OAuth2ClientCredentials
    fileprivate var oauth2: OAuth2
    {
        let clientType = oauth2PrivateClient.hasUnexpiredAccessToken() ? "private" : "public"
        Logger.log.verbose("Using \(clientType) OAuth client")
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
    
    fileprivate static func prepareUploadManager(_ settings: APIClientSettings) -> Alamofire.SessionManager
    {
        if let identifier = settings.backgroundSessionConfigurationIdentifier
        {
            let configuration = URLSessionConfiguration.background(withIdentifier: identifier)
            return Alamofire.SessionManager(configuration: configuration)
        }
        else
        {
            let configuration = URLSessionConfiguration.default
            return Alamofire.SessionManager(configuration: configuration)
        }
    }
    
    fileprivate static func prepareOauthPrivateClient(_ settings: APIClientSettings) -> OAuth2PasswordGrant
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
    
    fileprivate static func prepareOauthPublicClient(_ settings: APIClientSettings) -> OAuth2ClientCredentials
    {
        let oauthSettings =
        [
            "client_id": settings.appId,
            "client_secret": settings.appSecret,
            "authorize_uri": settings.authorizeUri,
            "token_uri":     settings.tokenUri,
            "keychain": false
        ]
        as OAuth2JSON
        
        let client = OAuth2ClientCredentials(settings: oauthSettings)
        
        client.verbose = false
        client.authorize()
        {
            (oauthJson, error) in
            if let error = error
            {
                Logger.log.error("Cannot login as Public Client! Error: \(error)")
            }
        }
        return client    }
    
    //MARK: - Authentication
    
    var authenticationToken: String? { return oauth2PrivateClient.accessToken }
    
    func login(_ username: String, password: String, completion: ErrorClosure?) -> RequestHandler
    {
        oauth2PrivateClient.username = username
        oauth2PrivateClient.password = password
        
        oauth2PrivateClient.authorize()
        {
            (oauth2JSON, error) in
            if let error = error
            {
                Logger.log.error("Error while login:\(error)")
                completion?(RequestSender.errorFromLoginError(error))
            }
            else
            {
                Logger.log.debug("User logged in successfully")
                completion?(nil)
            }
        }
        
        return RequestHandler(object: oauth2PrivateClient)
    }
    
    fileprivate class func errorFromLoginError(_ error: Error?) -> APIClientError
    {
        if let err = error as? OAuth2Error
        {
            return ErrorTransformer.errorFromOAuthError(err)
        }
        if let err = error as? NSError
        {
            return ErrorTransformer.errorFromNSError(err)
        }
        
        return APIClientError.genericLoginError
    }
    
    func currentSessionData() -> SessionData {
        return SessionData(accessToken: oauth2PrivateClient.accessToken, idToken: oauth2PrivateClient.idToken, accessTokenExpiry: oauth2PrivateClient.accessTokenExpiry, refreshToken: oauth2PrivateClient.refreshToken)
    }
    
    func setSessionData(_ sessionData: SessionData) {
        oauth2PrivateClient.idToken = sessionData.idToken
        oauth2PrivateClient.accessToken = sessionData.accessToken
        oauth2PrivateClient.accessTokenExpiry = sessionData.accessTokenExpiry
        oauth2PrivateClient.refreshToken = sessionData.refreshToken
    }
    
    func invalidateTokens() {
        oauth2PrivateClient.forgetTokens()
    }
    
    func logout()
    {
        invalidateTokens()
    }
    
    func isLoggedIn() -> Bool
    {
        return oauth2PrivateClient.hasUnexpiredAccessToken()
    }
    
    //MARK: - Request sending
    func send(_ request: Request, withResponseHandler handler: ResponseHandler) -> RequestHandler
    {
        Logger.log.debug("Sending request: \(type(of: request))")
        let headers: Dictionary<String, String>? = settings.locale == nil ? nil : ["Accept-Language" : settings.locale!]

        let sessionManager = SessionManager()
        let retrier = OAuth2RetryHandler(oauth2: oauth2)
        sessionManager.retrier = retrier
        sessionManager.adapter = retrier
        self.alamofireManager = sessionManager
        
        sessionManager.request(urlStringWithRequest(request), method: alamofireMethod(request.method), parameters: request.parameters, encoding:  URLEncoding.default, headers: headers).validate().response
        {
            response in
            if let err = response.error
            {
                  Logger.log.error("Error while sending request:\(type(of: request)) \nError:\n \(err) \nResponse:\n \(response)")
            }
        }
        .responseJSON
        {
            response -> Void in
            DispatchQueue.global().async
            {
                handler.handleResponse((response.result.value as? Dictionary<String, AnyObject>),error: response.result.error)
            }
        }
        
        return RequestHandler(object: request as! Cancelable)
        
//        let request = oauth2.request(alamofireMethod(request.method), urlStringWithRequest(request), parameters:request.parameters, headers: headers)
//            .responseString
//            {
//                (response) -> Void in
//                if let err = response.result.error
//                {
//                      Logger.log.error("Error while sending request:\(request.dynamicType) \nError:\n \(err) \nResponse:\n \(response.result.value)")
//                      Logger.log.error("Error while sending request:\(type(of: request)) \nError:\n \(err) \nResponse:\n \(response.result.value)")
//                }
//            }
//            .responseJSON
        
        
        
//        let request2 = oauth2.request(alamofireMethod(request.method), urlStringWithRequest(request), parameters: request.parameters, encoding: URLEncoding.default, headers: headers)
//        {
//            (response) -> Void in
//            if let err = response.result.error
//            {
//                Logger.log.error("Error while sending request:\(type(of: request)) \nError:\n \(err) \nResponse:\n \(response.result.value)")
//            }
//        }
//        .responseJSON
//        {
//            response -> Void in
//            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
//            dispatch_async(dispatch_get_global_queue(priority, 0)) {
//                handler.handleResponse((response.result.value as? Dictionary<String, AnyObject>),error: response.result.error)
//            }
//        }
//        return RequestHandler(object: request)
    }
    
    //MARK: - Creation sending
    func send(_ creationData: NewCreationData, uploadData: CreationUpload, progressChanged: @escaping (_ completedUnitCount: Int64, _ totalUnitCount: Int64, _ fractionCompleted: Double) -> Void, completion: @escaping (_ error: Error?) -> Void) -> RequestHandler
    {
        if(creationData.dataType == .image)
        {
            Logger.log.debug("Uploading data with identifier:\(uploadData.identifier) to:\(uploadData.uploadUrl)")
    
             let request = Alamofire.upload(UIImagePNGRepresentation(creationData.image!)!,
                                            to: uploadData.uploadUrl, method: .put, headers: ["Content-Type":uploadData.contentType]).uploadProgress(closure:
            {
                progress in
                Logger.log.verbose("Uploading progress for data with identifier:\(uploadData.identifier) \n \(progress.fractionCompleted)")
                progressChanged(progress.completedUnitCount, progress.totalUnitCount, progress.fractionCompleted)
            }).responseString()
            {
                response in
                Logger.log.verbose("Uploading finished for data with identifier:\(uploadData.identifier)")
                completion(response.result.error)
            }
            
            return RequestHandler(object: request)
        }
        else if(creationData.dataType == .url)
        {
            Logger.log.debug("Uploading data with identifier:\(uploadData.identifier) to:\(uploadData.uploadUrl)")
            
            let request = Alamofire.upload(creationData.url!, to: uploadData.uploadUrl, method: .put, headers: ["Content-Type":uploadData.contentType]).uploadProgress(closure:
            {
                progress in
                
                Logger.log.verbose("Uploading progress for data with identifier:\(uploadData.identifier) \n \(progress.fractionCompleted)")
                progressChanged(progress.completedUnitCount, progress.totalUnitCount, progress.fractionCompleted)
            }).responseString()
            {
                response in
                Logger.log.verbose("Uploading finished for data with identifier:\(uploadData.identifier)")
                completion(response.result.error)
            }
            
            return RequestHandler(object: request)
        }
        else
        {
            assert(creationData.dataType == .data)
            
            Logger.log.debug("Uploading data with identifier:\(uploadData.identifier) to:\(uploadData.uploadUrl)")
            
            let request = Alamofire.upload(creationData.data!, to: uploadData.uploadUrl, method: .put, headers: ["Content-Type":uploadData.contentType]).uploadProgress(closure:
                {
                    progress in
                    
                    Logger.log.verbose("Uploading progress for data with identifier:\(uploadData.identifier) \n \(progress.fractionCompleted)")
                    progressChanged(progress.completedUnitCount, progress.totalUnitCount, progress.fractionCompleted)
            }).responseString()
                {
                    response in
                    Logger.log.verbose("Uploading finished for data with identifier:\(uploadData.identifier)")
                    completion(response.result.error)
            }
            
            return RequestHandler(object: request)
        }
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
    fileprivate func urlStringWithRequest(_ request: Request) -> String
    {
        return String(format: "%@/%@/%@", arguments: [settings.baseUrl, settings.apiVersion, request.endpoint])
    }
    
    fileprivate func alamofireMethod(_ method: RequestMethod) -> Alamofire.HTTPMethod
    {
        switch method
        {

            case .options:  return .options
            case .get:      return .get
            case .head:     return .head
            case .post:     return .post
            case .put:      return .put
            case .patch:    return .patch
            case .delete:   return .delete
            case .trace:    return .trace
            case .connect:  return .connect
        }
    }
}
