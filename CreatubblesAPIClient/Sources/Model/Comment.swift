//
//  Comment.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 17.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
public class Comment: NSObject
{
    public var identifier: String
    public var text: String
    public var approved: Bool
    public var createdAt: NSDate
    public var commentableType: String
    public var commenterId: String
    
    public let commentedUserId: String?
    public let commentedCreationId: String?
    public let commentedGalleryId: String?
    
    init(mapper: CommentMapper)
    {
        identifier = mapper.identifier!
        text = mapper.text!
        approved = mapper.approved!
        createdAt = mapper.createdAt!
        commentableType = mapper.commentableType!
        commenterId = mapper.commenterId!
        
        commentedUserId = mapper.commentedUserId
        commentedCreationId = mapper.commentedCreationId
        commentedGalleryId = mapper.commentedGalleryId
    }

}
