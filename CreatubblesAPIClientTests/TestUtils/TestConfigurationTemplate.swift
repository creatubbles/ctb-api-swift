//
//  TestConfigurationTemplate.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 05.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

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
    static let apiPrefix = "TEST_API_PREFIX"
    
    static let username = "TEST_USERNAME"
    static let password = "TEST_PASSWORD"
    
    static var settings: CreatubblesAPIClientSettings
    {
        return CreatubblesAPIClientSettings(
                appId: appId,
                appSecret: appSecret,
                tokenUri: tokenUri,
                authorizeUri: authorizeUri,
                baseUrl: baseUrl,
                apiVersion: apiVersion,
                apiPrefix: apiPrefix)
    }
}
