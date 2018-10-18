//
//  RequestSender.swift
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

public class RequestSender: NSObject {
    fileprivate var networkManager: NetworkManager
    fileprivate var uploadManager: UploadManager
    open let settings: APIClientSettings

    init(settings: APIClientSettings) {
        self.settings = settings
        self.networkManager = NetworkManager(settings: settings)
        self.uploadManager = UploadManager(settings: settings)
        super.init()
    }

    // MARK: - Authentication

    var authenticationToken: String? {
        get {
            return networkManager.authClient.privateAccessToken
        }
        set {
            networkManager.authClient.privateAccessToken = newValue
        }
    }

    @discardableResult
    func login(_ username: String, password: String, completion: ErrorClosure?) -> RequestHandler {
        let request = AuthenticationRequest(username: username, password: password, settings: settings)

        return excuteAuthenticationRequest(request: request, isPublicAuthentication: false, completion: completion)
    }

    @discardableResult
    func authenticate(completion: ErrorClosure?) -> RequestHandler {
        let request = AuthenticationRequest(username: nil, password: nil, settings: settings)

        return excuteAuthenticationRequest(request: request, isPublicAuthentication: true, completion: completion)
    }

    public func excuteAuthenticationRequest(request: AuthenticationRequest, isPublicAuthentication: Bool, completion: ErrorClosure?) -> RequestHandler {
        self.networkManager.dataTask(request: request) { (response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    Logger.log(.error, "Error while login:\(String(describing: response))")

                    if isPublicAuthentication {
                        self.networkManager.authClient.publicAccessToken = nil
                    } else {
                        self.networkManager.authClient.privateAccessToken = nil
                    }

                    guard let response = response else {
                        completion?(error)
                        return
                    }

                    if let err_msg = response["error_description"] as? String {
                        completion?(RequestSender.errorFromLoginError(AuthenticationError.responseError(err_msg)))
                    } else if let err_code = response["error"] as? String {
                        completion?(RequestSender.errorFromLoginError(AuthenticationError.fromResponseError(err_code)))
                    }

                    return
                }

                if let accessToken = response?["access_token"] as? String {

                    if isPublicAuthentication {
                        self.networkManager.authClient.publicAccessToken = accessToken
                    } else {
                        self.networkManager.authClient.privateAccessToken = accessToken
                    }
                }
                completion?(nil)
            }
        }

        return RequestHandler(object: request as Cancelable)
    }

    fileprivate class func errorFromLoginError(_ error: Error?) -> APIClientError {
        if let err = error as? AuthenticationError {
            return ErrorTransformer.errorFromAuthenticationError(err)
        }

        if let err = error as NSError? {
            return ErrorTransformer.errorFromNSError(err)
        }

        return APIClientError.genericLoginError
    }

    func logout() {
        networkManager.authClient.logout()
    }

    func isLoggedIn() -> Bool {
        return networkManager.authClient.privateAccessToken != nil
    }

    // MARK: - Request sending

    @discardableResult

    public func send(_ request: Request, withResponseHandler handler: ResponseHandler) -> RequestHandler {
        Logger.log(.debug, "Sending request: \(type(of: request))")

        self.networkManager.dataTask(request: request) { (response, error) in
            if let error = error {
                guard let response = response else {
                    handler.handleResponse(nil, error: error)
                    return
                }

                Logger.log(.error, "Error while sending request:\(type(of: request))\nError:\nResponse:\n\(response)")
                handler.handleResponse(nil, error: ErrorTransformer.errorsFromResponse(response as? Dictionary<String, AnyObject>).first)
            } else {
                DispatchQueue.global().async {
                    if let response = response as? Dictionary<String, AnyObject> {
                        handler.handleResponse(response, error: nil)
                    } else if let array = response as? Array<AnyObject> {
                        // Added this case to handle non standard json-api format array response
                        handler.handleResponse(["data": array as AnyObject], error: nil)
                    } else {
                        handler.handleResponse((response as? Dictionary<String, AnyObject>), error: nil)
                    }
                }
            }
        }

        return RequestHandler(object: request as Cancelable)
    }

    // MARK: - Creation sending

    func send(_ creationData: NewCreationData, uploadData: CreationUpload, progressChanged: @escaping (_ completedUnitCount: Int64, _ totalUnitCount: Int64, _ fractionCompleted: Double) -> Void, completion: @escaping (_ error: Error?) -> Void) -> RequestHandler {

        var request = URLRequest(url: URL(string: uploadData.uploadUrl)!)
        request.httpMethod = "PUT"
        request.setValue(uploadData.contentType, forHTTPHeaderField: "Content-Type")

        let uploadTask: UploadTask!
        switch creationData.dataType {
        case .image:
            uploadTask = uploadManager.upload(request: request, fromData: UIImagePNGRepresentation(creationData.image!)!)
        case .data:
            uploadTask = uploadManager.upload(request: request, fromData: creationData.data!)
        case .url:
            uploadTask = uploadManager.upload(request: request, fromFile: creationData.url!)
        }

        uploadTask.uploadProgressHandler = { progress in
            Logger.log(.verbose, "Uploading progress for data with identifier:\(uploadData.identifier) \n \(progress.fractionCompleted)")
            progressChanged(progress.completedUnitCount, progress.totalUnitCount, progress.fractionCompleted)
        }

        uploadTask.completionHandler = { error in
            Logger.log(.verbose, "Uploading finished for data with identifier:\(uploadData.identifier)")
            completion(error)
        }

        return RequestHandler(object: uploadTask)
    }

    var backgroundCompletionHandler: (() -> Void)? {
        get {
            return uploadManager.backgroundCompletionHandler
        }
        set {
            uploadManager.backgroundCompletionHandler = newValue
        }
    }
}
