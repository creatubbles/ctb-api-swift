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
    override var method: RequestMethod  { return .get }
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
    
    fileprivate let creationId: String?
    fileprivate let galleryId: String?
    fileprivate let userId: String?
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
            params["page"] = page as AnyObject?
        }
        if let perPage = perPage
        {
            params["per_page"] = perPage as AnyObject?
        }
        return params
    }
}
