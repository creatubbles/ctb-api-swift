//
//  ReportCommentRequest.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 14.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class ReportCommentRequest: Request {
    
    override var method: RequestMethod  { return .POST }
    override var endpoint: String       { return "comments/\(commentId)/report" }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    
    private let commentId: String
    private let message: String
    
    init(commentId: String, message: String) {
        self.commentId = commentId
        self.message = message
    }
    
    private func prepareParameters() -> Dictionary<String,AnyObject> {
        var params = Dictionary<String,AnyObject>()
        params["message"] = message
        
        return params
    }
}