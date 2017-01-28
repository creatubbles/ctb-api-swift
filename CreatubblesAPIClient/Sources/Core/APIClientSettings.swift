//
//  CreatubblesAPIClientSettings.swift
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

open class APIClientSettings: NSObject
{
    /*
     Personal application identifier. Please contact support@creatubbles.com to obtain it.
    */
    public let appId: String
    
    /*
     Personal application secret. Please contact support@creatubbles.com to obtain it.
     */
    public let appSecret: String
    
    /*
        OAuth2 token uri. https://api.creatubbles.com/v2/oauth/token by default.
     */
    public let tokenUri: String
    
    /*
        OAuth2 authorization uri. https://api.creatubbles.com/v2/oauth/token by default.
    */
    let authorizeUri: String
    
    /*
        API base url.https://api.creatubbles.com by default.
    */
    let baseUrl: String
    
    /*
        API version string. 'v2' by defaults.
    */
    let apiVersion: String
    
    /*
        Background session configuration identifier.
        If set, application will upload creation using background sessions.
    */
    let backgroundSessionConfigurationIdentifier: String?
    
    /*
        Locale code used for getting localized responses from servers. Example values: “en”, “pl”, “de”.
        See: https://partners.creatubbles.com/api/#locales for details
    */
    let locale: String?
    
    /*
        Internal logging level. '.warning' by default
     */
    let logLevel: LogLevel
    
    public init(appId: String, appSecret: String, backgroundSessionConfigurationIdentifier: String? = nil, locale: String? = nil, logLevel: LogLevel = .warning)
    {
        self.appId = appId
        self.appSecret = appSecret
        self.tokenUri = "https://api.creatubbles.com/v2/oauth/token"
        self.authorizeUri = "https://api.creatubbles.com/v2/oauth/token"
        self.baseUrl = "https://api.creatubbles.com"
        self.apiVersion = "v2"
        self.locale = locale
        self.logLevel = logLevel
        self.backgroundSessionConfigurationIdentifier = backgroundSessionConfigurationIdentifier
    }
    
    public init(appId: String, appSecret: String, tokenUri: String, authorizeUri: String, baseUrl: String, apiVersion: String, locale: String? = nil, logLevel: LogLevel = .warning,  backgroundSessionConfigurationIdentifier: String? = nil)
    {
        self.appId = appId
        self.appSecret = appSecret
        self.tokenUri = tokenUri
        self.authorizeUri = authorizeUri
        self.baseUrl = baseUrl
        self.apiVersion = apiVersion
        self.locale = locale
        self.logLevel = logLevel
        self.backgroundSessionConfigurationIdentifier = backgroundSessionConfigurationIdentifier
    }
}
