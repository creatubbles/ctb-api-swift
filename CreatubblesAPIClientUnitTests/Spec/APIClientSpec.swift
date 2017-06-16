//
//  CreatubblesAPIClientSpec.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2017 Creatubbles Pte. Ltd.
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
import Quick
import Nimble
@testable import CreatubblesAPIClient

class APIClientSpec: QuickSpec {
    override func spec() {
        describe("ApiClient Settings") {
            it("Have proper fields set") {
                let appId = "TestAppId"
                let appSecret = "TestAppSecret"
                let tokenUri = "TestTokenUri"
                let authorizeUri = "TestAuthorizeUri"
                let baseUrl = "TestBaseUrl"
                let apiVersion = "TestApiVersion"

                let settings = APIClientSettings(appId: appId, appSecret: appSecret, tokenUri: tokenUri, authorizeUri: authorizeUri, baseUrl: baseUrl, apiVersion: apiVersion)

                expect(settings.appId) == appId
                expect(settings.appSecret) == appSecret
                expect(settings.tokenUri) == tokenUri
                expect(settings.authorizeUri) == authorizeUri
                expect(settings.baseUrl) == baseUrl
                expect(settings.apiVersion) == apiVersion
            }
        }

        describe("APIClient") {
            // MARK: - Should have all public DA
            it("Should have all public DAO's registered") {
                let appId = "TestAppId"
                let appSecret = "TestAppSecret"
                let tokenUri = "TestTokenUri"
                let authorizeUri = "TestAuthorizeUri"
                let baseUrl = "TestBaseUrl"
                let apiVersion = "TestApiVersion"

                let settings = APIClientSettings(appId: appId, appSecret: appSecret, tokenUri: tokenUri, authorizeUri: authorizeUri, baseUrl: baseUrl, apiVersion: apiVersion)

                let client = APIClient(settings: settings)
                expect(client.daoAssembly.assembly(GroupDAO.self)).notTo(beNil())
                expect(client.daoAssembly.assembly(AvatarDAO.self)).notTo(beNil())
                expect(client.daoAssembly.assembly(BubbleDAO.self)).notTo(beNil())
                expect(client.daoAssembly.assembly(CommentsDAO.self)).notTo(beNil())
                expect(client.daoAssembly.assembly(CreationsDAO.self)).notTo(beNil())
                expect(client.daoAssembly.assembly(CustomStyleDAO.self)).notTo(beNil())
                expect(client.daoAssembly.assembly(DatabaseDAO.self)).notTo(beNil())
                expect(client.daoAssembly.assembly(GalleryDAO.self)).notTo(beNil())
                expect(client.daoAssembly.assembly(UserDAO.self)).notTo(beNil())
                expect(client.daoAssembly.assembly(ContentDAO.self)).notTo(beNil())
                expect(client.daoAssembly.assembly(NotificationDAO.self)).notTo(beNil())
                expect(client.daoAssembly.assembly(UserFollowingsDAO.self)).notTo(beNil())
                expect(client.daoAssembly.assembly(ActivitiesDAO.self)).notTo(beNil())
                expect(client.daoAssembly.assembly(PartnerApplicationDAO.self)).notTo(beNil())
                expect(client.daoAssembly.assembly(SearchTagDAO.self)).notTo(beNil())
            }
        }
    }
}
