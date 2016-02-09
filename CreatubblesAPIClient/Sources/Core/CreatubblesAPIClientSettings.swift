//
//  CreatubblesAPIClientSettings.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 05.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

public class CreatubblesAPIClientSettings: NSObject
{
    let appId: String
    let appSecret: String
    let tokenUri: String
    let authorizeUri: String
    let baseUrl: String
    let apiVersion: String
    let apiPrefix: String
    
    public init(appId: String, appSecret: String, tokenUri: String, authorizeUri: String, baseUrl: String, apiVersion: String, apiPrefix: String)
    {
        self.appId = appId
        self.appSecret = appSecret
        self.tokenUri = tokenUri
        self.authorizeUri = authorizeUri
        self.baseUrl = baseUrl
        self.apiVersion = apiVersion
        self.apiPrefix = apiPrefix
    }
}
