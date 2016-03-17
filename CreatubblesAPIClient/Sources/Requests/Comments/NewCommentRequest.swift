//
//  NewCommentRequest.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 17.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class NewCommentRequest: Request {

    
    override var method: RequestMethod  { return .POST }
    override var endpoint: String
    {
        switch data.type
        {
        case .Creation: return "galleries/\(data.commentedObjectIdentifier)/comments"
        case .Gallery:  return "creations/\(data.commentedObjectIdentifier)/comments"
        case .User:     return "users/\(data.commentedObjectIdentifier)/comments"
        }
    }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    
    private let data: NewCommentData
    
    init(data: NewCommentData)
    {
        self.data = data
    }
    
    private func prepareParameters() -> Dictionary<String,AnyObject>
    {
        var params = Dictionary<String,AnyObject>()
        switch data.type
        {
        case .Creation: params["creation_id"] = data.commentedObjectIdentifier
        case .Gallery:  params["gallery_id"] = data.commentedObjectIdentifier
        case .User:     params["user_id"] = data.commentedObjectIdentifier
        }
        if let text = data.text
        {
            params["text"] = text
        }
        return params
    }
}
