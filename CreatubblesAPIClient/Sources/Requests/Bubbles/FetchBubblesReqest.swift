//
//  FetchBubblesReqest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 16.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class FetchBubblesReqest: Request
{
    override var method: RequestMethod  { return .GET }
    override var parameters: Dictionary<String, AnyObject> { return Dictionary<String,AnyObject>() }
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
