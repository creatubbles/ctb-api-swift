//
//  CreatubblesAPIClientSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 05.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import Quick
import Nimble
@testable import CreatubblesAPIClient

class CreatubblesAPIClientSpec: QuickSpec
{
    override func spec()
    {
        describe("ApiClient Settings")
        {
            it("Have proper fields set")
            {
                let appId = "TestAppId"
                let appSecret = "TestAppSecret"
                let tokenUri = "TestTokenUri"
                let authorizeUri = "TestAuthorizeUri"
                let baseUrl = "TestBaseUrl"
                let apiVersion = "TestApiVersion"
                let apiPrefix = "TestApiPrefix"
                
                let settings = CreatubblesAPIClientSettings(appId: appId, appSecret: appSecret, tokenUri: tokenUri, authorizeUri: authorizeUri, baseUrl: baseUrl, apiVersion: apiVersion, apiPrefix: apiPrefix)
                
                expect(settings.appId).to(equal(appId))
                expect(settings.appSecret).to(equal(appSecret))
                expect(settings.tokenUri).to(equal(tokenUri))            
                expect(settings.authorizeUri).to(equal(authorizeUri))
                expect(settings.baseUrl).to(equal(baseUrl))
                expect(settings.apiVersion).to(equal(apiVersion))
                expect(settings.apiPrefix).to(equal(apiPrefix))
            }
        }
    }
}
