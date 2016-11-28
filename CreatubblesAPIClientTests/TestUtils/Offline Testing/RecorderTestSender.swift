//
//  RecorderTestSender.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 28.11.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
@testable import CreatubblesAPIClient

class RecorderTestSender: RequestSender
{
    override func send(_ request: Request, withResponseHandler handler: ResponseHandler) -> RequestHandler
    {
        let recorderHandler = RecorderResponseHandler(orignalHandler: handler, filenameToSave: filenameForRequest(request: request))
        
        
        
        return super.send(request, withResponseHandler: handler)
    }
    
    private func filenameForRequest(request: Request) -> String
    {
        var nameComponents = Array<String>()
        nameComponents.append(request.endpoint)
        nameComponents.append(request.method.rawValue)
        nameComponents.append(contentsOf: request.parameters.map({ "\($0):\($1)"}))
        nameComponents.append("loggedIn:\(isLoggedIn())")
        
        return nameComponents.joined(separator: "_")
    }
}
