 //
//  CommentsRequest.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 16.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class CommentsRequest: Request
{
    override var method: RequestMethod   { return .GET }
    override var parameters: Dictionary<String, AnyObject> { return Dictionary<String, AnyObject>() }
    override var endpoint: String
    {
        if let creationId = creationId {
            return "creations/\(creationId)/comments"
        }
        if let galleryId = galleryId {
            return "galleries/\(galleryId)/comments"
        }
        if let userId = userId {
            return "users/\(userId)/comments"
        }
        return ""

    }
    private var creationId: String?
    private var galleryId: String?
    private var userId: String?
    
    init(creationId: String)
    {
        self.creationId = creationId
        self.galleryId = nil
        self.userId = nil
    }
    
    init(galleryId: String)
    {
        self.creationId = nil
        self.galleryId = galleryId
        self.userId = nil
    }
    
    init(userId: String)
    {
        self.creationId = nil
        self.galleryId = nil
        self.userId = userId
    }
    
}
