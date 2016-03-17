//
//  CommentsMapper.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 17.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class CommentMapper: Mappable
{
    public var identifier: String?
    public var text: String?
    public var approved: Bool?
    public var createdAt: NSDate?
    public var commentableType: String?
    public var commenterId: String?
    
    public let commentedUserId: String?
    public let commentedCreationId: String?
    public let commentedGalleryId: String?
    
    required init?(_ map: Map)
    {
        
    }
    
    func mapping(map: Map)
    {
        identifier <- map["id"]
        text <- map["text"]
        approved <- map["approved"]
        createdAt <- map["created_at"]
        commentableType <- map["commentable_type"]
        commenterId <- map["relationships.commenter.data.id"]
        
        commentedUserId <- map["relationships.user.data.id"]
        commentedCreationId <- map["relationships.creation.data.id"]
        commentedGalleryId <- map["relationships.gallery.data.id"]
    }
    
}
