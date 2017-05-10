//
//  DemoWelcomeViewController.swift
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

import UIKit
import CreatubblesAPIClient
import SafariServices

class DemoWelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func oauthSignInPressed(_ sender: Any) {
        guard let url = URL(string: OAuthExampleConstants.oauthTokenUri) else {
            return
        }

        if !DemoAPIClient.sharedInstance.client.isLoggedIn() {
            let safariVC = SFSafariViewController(url: url)
            safariVC.delegate = self
            present(safariVC, animated: true, completion: nil)
        } else {
            let demoAuthenticatedViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DemoAuthenticatedViewController")
            navigationController?.pushViewController(demoAuthenticatedViewController, animated: true)
        }
    }
}

extension DemoWelcomeViewController: SFSafariViewControllerDelegate {
    public func handleOpenUrl(url: URL) {
        let codeKey = "code="
        let queryParams = url.query?.components(separatedBy: "&")
        let codeParam = queryParams?.filter {
            element in
            // 5 becaues "code=" has 5 characters.
            return String(element.characters.prefix(5)) == codeKey
        }
        let codeQuery = codeParam?.first
        let optionalCode = codeQuery?.replacingOccurrences(of: codeKey, with: "")

        guard let code = optionalCode else {
            let alert = UIAlertController(title: "Error", message: "Authentication code is missing", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        let authRequest = AuthenticationRequest(code: code, redirectURI: OAuthExampleConstants.redirectURI, settings: OAuthExampleConstants.settings)
        let _ = DemoAPIClient.sharedInstance.client.requestSender.excuteAuthenticationRequest(request: authRequest, isPublicAuthentication: false, completion: {
            [weak self]
            error in
            guard let strongSelf = self else {
                return
            }
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.description, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                strongSelf.present(alert, animated: true, completion: nil)
            } else {
                (strongSelf.presentedViewController ?? strongSelf).dismiss(animated: true, completion: {
                    let demoAuthenticatedViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DemoAuthenticatedViewController")
                    strongSelf.navigationController?.pushViewController(demoAuthenticatedViewController, animated: true)
                })
            }
        })
    }
}
