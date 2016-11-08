//
//  NewCommentRequest.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 17.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class NewCommentRequest: Request {

    
    override var method: RequestMethod  { return .post }
    override var endpoint: String
    {
        switch data.type
        {
            case .creation: return "creations/\(data.commentedObjectIdentifier)/comments"
            case .gallery:  return "galleries/\(data.commentedObjectIdentifier)/comments"
            case .user:     return "users/\(data.commentedObjectIdentifier)/comments"
        }
    }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    
    fileprivate let data: NewCommentData
    
    init(data: NewCommentData)
    {
        self.data = data
    }
    
    fileprivate func prepareParameters() -> Dictionary<String,AnyObject>
    {
        var params = Dictionary<String,AnyObject>()        
        if let text = data.text
        {
            params["text"] = text as AnyObject?
        }
        return params
    }
}
