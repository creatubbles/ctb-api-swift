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
    override var parameters: Dictionary<String, AnyObject> { return prepareParametersDict() }
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
    private var page: Int?
    private var perPage: Int?
    
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
    
    private func prepareParametersDict() -> Dictionary<String, AnyObject>
    {
        var params = Dictionary<String, AnyObject>()
        
        if let creationId = creationId
        {
            params["creation_id"] = creationId
        }
        
        if let galleryId = galleryId
        {
            params["gallery_id"] = galleryId
        }
        
        if let userId = userId
        {
            params["user_id"] = userId
        }
        
        if let page = page
        {
            params["page"] = page
        }
        
        if let perPage = perPage
        {
            params["perPage"] = perPage
        }
        
        return params
    }
    
}
