//
//  DemoAPIClient.swift
//  CreatubblesAPIClient
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

import CreatubblesAPIClient
import UIKit

struct OAuthExampleConstants {
    static let appId = "[YOUR APP IDENTIFIER HERE]"
    static let appSecret = "[YOUR APP SECRET HERE]"
    static let redirectURIScheme = "ctboauthexample"
    static let redirectURI = "\(redirectURIScheme)://testoauth"
    static let oauthTokenUri = "https://api.staging.creatubbles.com/v2/oauth/authorize?response_type=code&client_id=\(appId)&redirect_uri=\(redirectURI)"
    static let authorizeUri = "https://api.staging.creatubbles.com/v2/oauth/token"
    static let tokenUri = "https://api.staging.creatubbles.com/v2/oauth/token"
    static let baseUrl = "https://api.staging.creatubbles.com"
    static let apiVersion = "v2"
    static let oauthScope = "users:registrations"
    static let settings = APIClientSettings(appId: OAuthExampleConstants.appId, appSecret: OAuthExampleConstants.appSecret, tokenUri: OAuthExampleConstants.tokenUri, authorizeUri: OAuthExampleConstants.authorizeUri, baseUrl: OAuthExampleConstants.baseUrl, apiVersion: OAuthExampleConstants.apiVersion, logLevel: .warning, backgroundSessionConfigurationIdentifier: "something", oauthScope: OAuthExampleConstants.oauthScope)
}


class DemoAPIClient: APIClientDelegate {
    public static let sharedInstance: DemoAPIClient = DemoAPIClient()
    let client: CreatubblesAPIClient.APIClient

    private init() {
        self.client = DemoAPIClient.prepareClient()
        self.client.delegate = self
        self.client.authenticate {
            error in
            guard let error = error else {
                return
            }
            print("WARNING: Public authentication was not set properly:\(error)")
        }
    }

    fileprivate static func prepareClient() -> CreatubblesAPIClient.APIClient {
        return CreatubblesAPIClient.APIClient(settings: OAuthExampleConstants.settings)
    }

    func creatubblesAPIClientNewImageUpload(_ apiClient: APIClient, uploadSessionData: CreationUploadSessionPublicData)
    {

    }
    func creatubblesAPIClientImageUploadFinished(_ apiClient: APIClient, uploadSessionData: CreationUploadSessionPublicData)
    {

    }
    func creatubblesAPIClientImageUploadFailed(_ apiClient: APIClient,  uploadSessionData: CreationUploadSessionPublicData, error: NSError)
    {

    }
    func creatubblesAPIClientImageUploadProcessChanged(_ apiClient: APIClient, uploadSessionData: CreationUploadSessionPublicData, completedUnitCount: Int64, _ totalUnitCount: Int64, _ fractionCompleted: Double)
    {

    }
    func creatubblesAPIClientUserChanged(_ apiClient: APIClient)
    {

    }
}
