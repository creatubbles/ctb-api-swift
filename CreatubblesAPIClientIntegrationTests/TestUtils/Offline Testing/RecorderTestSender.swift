//
//  APIClientError.swift
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
//

import UIKit
@testable import CreatubblesAPIClient

class RecorderTestSender: RequestSender {
    var isLoggedIn: Bool?

    override func send(_ request: Request, withResponseHandler handler: ResponseHandler) -> RequestHandler {
        let fileName = TestRecorderNameUtils.filenameForRequest(request: request, isLoggedIn: isLoggedIn)
        let filePath = TestRecorderNameUtils.getInputFilePathForFileName(fileName: fileName)

        let recorderHandler = RecorderResponseHandler(originalHandler: handler, fileToSavePath: filePath, isLoggedIn: isLoggedIn)

        if TestConfiguration.mode == .useRecordedResponses {
            let testRecorder = TestRecorder(isLoggedIn: isLoggedIn)
            return testRecorder.handleRequest(request: request, recorderHandler: recorderHandler)
        }

        if TestConfiguration.mode == .useAPIAndRecord {
            return super.send(request, withResponseHandler: recorderHandler)
        } else {
            return super.send(request, withResponseHandler: handler)
        }
    }

    override func login(_ username: String, password: String, completion: ErrorClosure?) -> RequestHandler {
        if TestConfiguration.mode == .useAPIAndRecord {
            isLoggedIn = true
        } else if TestConfiguration.mode == .useRecordedResponses {
            isLoggedIn = true
            let request = AuthenticationRequest(username: username, password: password, settings: TestConfiguration.settings)
            completion?(nil)
            return RequestHandler(object: request as Cancelable)
        }
        return super.login(username, password: password, completion: completion)
    }

    override func logout() {
        if TestConfiguration.mode == .useRecordedResponses || TestConfiguration.mode == .useRecordedResponses {
            isLoggedIn = false
        }
        super.logout()
    }
}
