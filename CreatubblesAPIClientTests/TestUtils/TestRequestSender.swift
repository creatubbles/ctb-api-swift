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
    
    override init(settings: CreatubblesAPIClientSettings)
    {
        self.settings = settings
        super.init(settings: settings)
    }
    
    //MARK: - Interface
    override func login(username: String, password: String, completion: (ErrorType?) -> Void)
    {
        
    }
    
    override func logout()
    {
        
    }
    
    override func send(request: Request, withResponseHandler handler: ResponseHandler)
    {
        
    }
}
