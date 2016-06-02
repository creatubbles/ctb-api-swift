//
//  TestConfiguration.swift
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

import Foundation
import CreatubblesAPIClient

class TestConfiguration: NSObject
{
    static let appId = "1a36f7c51e4d357f7f106377fc39701c24dfaa66adef95234fb800b86b0918a1"
    static let appSecret = "a4ac462b625880a83b1c09b7df500572309576f4c1c9744866903d9e372993ab"
    static let tokenUri = "https://api.staging.creatubbles.com/v2/oauth/token"
    static let authorizeUri = "https://api.staging.creatubbles.com/v2/oauth/token"
    
    static let baseUrl = "https://api.staging.creatubbles.com"
    static let apiVersion = "v2"
    
    static let username = "m.miedlarz@nomtek.com"
    static let password = "wodaPolaris"
    
    static let testCreationIdentifier: String? = "yJZvTNU7"
    static let testUserIdentifier: String? = "dSPX04ab"
    static let testGalleryIdentifier: String? = "UJdWt1bD"
    static let testBubbleIdentifier: String? = nil
    static let shouldTestUpload: Bool = false
    
    static var settings: APIClientSettings
    {
        return APIClientSettings(
            appId: appId,
            appSecret: appSecret,
            tokenUri: tokenUri,
            authorizeUri: authorizeUri,
            baseUrl: baseUrl,
            apiVersion: apiVersion
        )
    }
}
