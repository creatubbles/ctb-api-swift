//
//  BubblesFetchReqest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 16.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class BubblesFetchReqest: Request
{
    override var method: RequestMethod  { return .GET }
    override var parameters: Dictionary<String, AnyObject> { return prepareParametersDictionary() }
    override var endpoint: String
    {
        if let creationId = creationId {
            return "creations/\(creationId)/bubbles"
        }
        if let galleryId = galleryId {
            return "galleries/\(galleryId)/bubbles"
        }
        if let userId = userId {
            return "users/\(userId)/bubbles"
        }
        return ""
    }
    
    private let creationId: String?
    private let galleryId: String?
    private let userId: String?
    private let page: Int?
    private let perPage: Int?
    
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
        self.page = page
        self.perPage = perPage
        
        self.creationId = nil
        self.galleryId = galleryId
        self.userId = nil
    }
    
    init(userId: String, page: Int?, perPage: Int?)
    {
        self.page = page
        self.perPage = perPage
        
        self.creationId = nil
        self.galleryId = nil
        self.userId = userId
    }
    
    func prepareParametersDictionary() -> Dictionary<String, AnyObject>
    {
        var params = Dictionary<String, AnyObject>()
        
        if let page = page
        {
            params["page"] = page
        }
        if let perPage = perPage
        {
            params["per_page"] = perPage
        }
        return params
    }
}
