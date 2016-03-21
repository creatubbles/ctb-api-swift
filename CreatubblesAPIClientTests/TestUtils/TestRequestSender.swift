//
//  TestRequestSender.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2016 Creatubbles Pte. Ltd.
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
@testable import CreatubblesAPIClient

class TestRequestSender: RequestSender
{
    private let settings: CreatubblesAPIClientSettings
    private var isLoggedIn = false
    
    override init(settings: CreatubblesAPIClientSettings)
    {
        self.settings = settings
        super.init(settings: settings)
    }
    
    //MARK: - Interface
    override func login(username: String, password: String, completion: ErrorClosure?)
    {
        let authorized = username == TestConfiguration.username &&
                         password == TestConfiguration.password

        let error: CreatubblesAPIClientError? = authorized ? nil : CreatubblesAPIClientError.Generic("CreatubblesTest - Not Logged In")
        isLoggedIn = authorized
        completion?(error)
    }
    
    override func logout()
    {
        isLoggedIn = false
    }
    
    override func send(request: Request, withResponseHandler handler: ResponseHandler)
    {
        Logger.log.debug("Sending request: \(request.dynamicType)")
        if(isLoggedIn)
        {
            handler.handleResponse(responseForRequest(request), error: nil)
        }
        else
        {
            let error = CreatubblesAPIClientError.Generic("CreatubblesTest - Not Logged In")
            handler.handleResponse(nil, error: error)
        }
    }
    
    private func responseForRequest(request: Request) -> Dictionary<String, AnyObject>
    {
        if request is ProfileRequest
        {
            return TestResponses.profileTestResponse
        }
        if request is CreatorsAndManagersRequest
        {
            return TestResponses.creatorsAndManagersTestResponse
        }
        if request is NewCreatorRequest
        {
            return TestResponses.newCreatorTestResponse
        }
        if request is GalleriesRequest && request.endpoint.containsString("/")
        {
            return TestResponses.singleGalleryTestResponse
        }
        if request is GalleriesRequest && !request.endpoint.containsString("/")
        {
            return TestResponses.galleriesTestResponse
        }
        if request is NewGalleryRequest
        {
            return TestResponses.newGalleryTestResponse
        }
        if request is NewCreationRequest
        {
            return TestResponses.newCreationTestResponse
        }
        if request is NewCreationUploadRequest
        {
            return TestResponses.newCreationUploadTestResponse
        }
        if request is FetchCreationsRequest
        {
            return TestResponses.fetchCreationsTestResponse
        }
        if request is GallerySubmissionRequest
        {
            return TestResponses.gallerySubmissionTestResponse
        }
                
        return Dictionary<String, AnyObject>()
    }
}