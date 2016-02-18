//
//  TestRequestSender.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 10.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

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
    override func login(username: String, password: String, completion: (ErrorType?) -> Void?)
    {
        let authorized = username == TestConfiguration.username &&
                         password == TestConfiguration.password
        let error: NSError? = authorized ? nil : NSError(domain: "CreatubblesTest", code: 0, userInfo: nil)
        isLoggedIn = authorized
        completion(error)
    }
    
    override func logout()
    {
        isLoggedIn = false
    }
    
    override func send(request: Request, withResponseHandler handler: ResponseHandler)
    {
        if(isLoggedIn)
        {
            handler.handleResponse(responseForRequest(request), error: nil)
        }
        else
        {
            let error = NSError(domain: "Creatubbles Test", code: 0, userInfo: nil)
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
        
        
        return Dictionary<String, AnyObject>()
    }
}