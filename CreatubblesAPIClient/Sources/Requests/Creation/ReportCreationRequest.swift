//
//  ReportCreationRequest.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 14.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class ReportCreationRequest: Request {
    
    override var method: RequestMethod  { return .POST }
    override var endpoint: String       { return "creations/\(creationId)/report" }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    
    private let creationId: String
    private let message: String
    
    init(creationId: String, message: String) {
        self.creationId = creationId
        self.message = message
    }
    
    private func prepareParameters() -> Dictionary<String,AnyObject> {
        var params = Dictionary<String,AnyObject>()
        params["message"] = message
        
        return params
    }
}