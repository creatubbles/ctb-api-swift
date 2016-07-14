//
//  ReportUserRequest.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 14.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class ReportUserRequest: Request {
    
    override var method: RequestMethod  { return .POST }
    override var endpoint: String       { return "users/\(userId)/report" }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    
    private let userId: String
    private let message: String
    
    init(userId: String, message: String) {
        self.userId = userId
        self.message = message
    }
    
    private func prepareParameters() -> Dictionary<String,AnyObject> {
        var params = Dictionary<String,AnyObject>()
        params["message"] = message
        
        return params
    }
}