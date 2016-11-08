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
    override var method: RequestMethod   { return .get }
    override var parameters: Dictionary<String, AnyObject> { return prepareParametersDictionary() }
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
    
    fileprivate var creationId: String?
    fileprivate var galleryId: String?
    fileprivate var userId: String?
    fileprivate let page: Int?
    fileprivate let perPage: Int?
    
    init(creationId: String, page: Int?, perPage: Int?)
    {
        self.creationId = creationId
        self.page = page
        self.perPage = perPage
        self.galleryId = nil
        self.userId = nil
    }
    
    init(galleryId: String, page: Int?, perPage: Int?)
    {
        self.creationId = nil
        self.page = page
        self.perPage = perPage
        self.galleryId = galleryId
        self.userId = nil
    }
    
    init(userId: String, page: Int?, perPage: Int?)
    {
        self.creationId = nil
        self.page = page
        self.perPage = perPage
        self.galleryId = nil
        self.userId = userId
    }
    
    func prepareParametersDictionary() -> Dictionary<String, AnyObject>
    {
        var params = Dictionary<String, AnyObject>()
        
        if let page = page
        {
            params["page"] = page as AnyObject?
        }
        if let perPage = perPage
        {
            params["per_page"] = perPage as AnyObject?
        }
        return params
    }    
}
