//
//  DetailViewController.swift
//  CreatubblesAPIClientDemo
//
//  Created by Benjamin Hendricks on 4/28/17.
//  Copyright © 2017 Nomtek. All rights reserved.
//

import UIKit
import CreatubblesAPIClient
import SafariServices

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


class APIClientAccessSingleton: NSObject {
    public static let sharedInstance: APIClientAccessSingleton = APIClientAccessSingleton()
    let client = APIClient.prepareClient()
    internal override required init() {}
}

class OAuthDemoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        APIClientAccessSingleton.sharedInstance.client.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let url = URL(string: OAuthExampleConstants.oauthTokenUri) else {
            return
        }
        
        if !APIClientAccessSingleton.sharedInstance.client.isLoggedIn() {
            let alert = UIAlertController(title: "Hi :)", message: "Would you like to login to Creatubbles now?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
                action in
                let safariVC = SFSafariViewController(url: url)
                safariVC.delegate = self
                self.present(safariVC, animated: true, completion: nil)
            }))
            present(alert, animated: true, completion: nil)
        }
    }
}

extension OAuthDemoViewController: SFSafariViewControllerDelegate {
    public func handleOpenUrl(url: URL) {
        let codeKey = "code="
        let queryParams = url.query?.components(separatedBy: "&")
        let codeParam = queryParams?.filter {
            element in
            return String(element.characters.prefix(5)) == codeKey
        }
        let codeQuery = codeParam?.first
        let code = codeQuery?.replacingOccurrences(of: codeKey, with: "")
        
        if let code = code {
            let authRequest = AuthenticationRequest(code: code, redirectURI: OAuthExampleConstants.redirectURI, settings: OAuthExampleConstants.settings)
            let _ = APIClientAccessSingleton.sharedInstance.client.requestSender.excuteAuthenticationRequest(request: authRequest, isPublicAuthentication: false, completion: {
                [weak self]
                error in
                guard let strongSelf = self else {
                    return
                }
                if let error = error {
                    print(error)
                    let alert = UIAlertController(title: "Error", message: error.description, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    strongSelf.present(alert, animated: true, completion: nil)
                } else {
                    print("AUTHENTICATION SUCCESSFUL")
                    (strongSelf.presentedViewController ?? strongSelf).dismiss(animated: true, completion: {
                        let alert = UIAlertController(title: "Success!", message: "You were successfully authenticated with Creatubbles", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        strongSelf.present(alert, animated: true, completion: nil)
                    })
                }
            })
        }
    }
}

extension OAuthDemoViewController: APIClientDelegate {
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

extension APIClient {
    fileprivate static func prepareClient() -> APIClient
    {
        
        return APIClient(settings: OAuthExampleConstants.settings)
    }
}
