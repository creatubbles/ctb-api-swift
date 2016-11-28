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
    override func send(_ request: Request, withResponseHandler handler: ResponseHandler, shouldUseRecordedResponses: Bool? = nil, shouldRecordResponseToFile: Bool? = nil) -> RequestHandler
    {
        let recorderHandler = RecorderResponseHandler(orignalHandler: handler, filenameToSave: filenameForRequest(request: request))
        
        recorderHandler.shouldRecordResponseToFile = self.shouldRecordResponseToFile

        if shouldUseRecordedResponses == true
        {
            guard let inputFilePath = getInputFilePath() else
            {
                let error = APIClientError(status: -6004, code: nil, title: "Missing Response", source: nil, detail: "Response file was not found.")
                handler.handleResponse(nil, error: error)
                return RequestHandler(object: request as Cancelable)
            }

            if let response = NSKeyedUnarchiver.unarchiveObject(withFile: inputFilePath)
            {
                if let error = ErrorTransformer.errorsFromResponse(response as? Dictionary<String, AnyObject>).first
                {
                    Logger.log.error("Error while sending request:\(type(of: request))\nError:\nResponse:\n\(response)")
                    handler.handleResponse(nil, error: error)
                }
                else if let error = response as? Error
                {
                    Logger.log.error("Error while sending request:\(type(of: request))\nError:\nResponse:\n\(response)")
                    handler.handleResponse(nil, error: error)
                }
                else
                {
                    DispatchQueue.global().async
                        {
                            handler.handleResponse((response as? Dictionary<String, AnyObject>),error: nil)
                    }
                }
            }
        }
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
