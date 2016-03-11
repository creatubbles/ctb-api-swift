//
//  TestConfigurationTemplate.swift
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
import CreatubblesAPIClient

class TestConfigurationTemplate: NSObject
{
    static let appId = "TEST_APP_ID"
    static let appSecret = "TEST_APP_SECRET"
    static let tokenUri = "TEST_TOKEN_URI"
    static let authorizeUri = "TEST_AUTH_URI"
    static let baseUrl = "TEST_BASE_URL"
    static let apiVersion = "TEST_API_VERSION"
    
    static let username = "TEST_USERNAME"
    static let password = "TEST_PASSWORD"
    
    static let testCreationIdentifier: String? = nil
    static let testUserIdentifier: String? = nil
    static let testGalleryIdentifier: String? = nil
    
    static var settings: CreatubblesAPIClientSettings
    {
        return CreatubblesAPIClientSettings(
                appId: appId,
                appSecret: appSecret,
                tokenUri: tokenUri,
                authorizeUri: authorizeUri,
                baseUrl: baseUrl,
                apiVersion: apiVersion
            )
    }
}
