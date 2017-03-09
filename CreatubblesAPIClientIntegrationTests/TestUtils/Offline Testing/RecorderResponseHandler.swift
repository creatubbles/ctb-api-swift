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

class RecorderResponseHandler: ResponseHandler
{
    private let originalResponseHandler: ResponseHandler
    private let fileToSavePath: String?
    private let isLoggedIn: Bool?
    
    init(originalHandler: ResponseHandler, fileToSavePath: String?, isLoggedIn: Bool?)
    {
        self.originalResponseHandler = originalHandler
        self.fileToSavePath = fileToSavePath
        self.isLoggedIn = isLoggedIn
    }
    
    override func handleResponse(_ response: Dictionary<String, AnyObject>?, error: Error?)
    {
    
        if let _ = fileToSavePath
        {
            let testRecorder = TestRecorder(isLoggedIn: isLoggedIn)
            testRecorder.saveResponseToFile(response, fileToSavePath: fileToSavePath, error: error)
        }
        
        originalResponseHandler.handleResponse(response, error: error)
    }
}
