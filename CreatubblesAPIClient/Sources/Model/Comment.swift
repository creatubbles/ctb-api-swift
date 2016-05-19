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
    
    public let commenter: User?
    public let commentedCreation: Creation?
    public let commentedGallery: Gallery?
    public let commentedUser: User?
    
    public let commenterRelationship: Relationship?
    public let commentedCreationRelationship: Relationship?
    public let commentedGalleryRelationship: Relationship?
    public let commentedUserRelationship: Relationship?
    
    init(mapper: CommentMapper, dataMapper: DataIncludeMapper? = nil)
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
        
        commenterRelationship = mapper.parseCommenterRelationship()
        commentedCreationRelationship = mapper.parseCommentedCreationRelationship()
        commentedGalleryRelationship = mapper.parseCommentedGalleryRelationship()
        commentedUserRelationship = mapper.parseCommentedUserRelationship()
        
        commenter = Comment.prepareObjectFromMapper(dataMapper, relationship: commenterRelationship, type: User.self)
        commentedCreation = Comment.prepareObjectFromMapper(dataMapper, relationship: commentedCreationRelationship, type: Creation.self)
        commentedGallery = Comment.prepareObjectFromMapper(dataMapper, relationship: commentedGalleryRelationship, type: Gallery.self)
        commentedUser = Comment.prepareObjectFromMapper(dataMapper, relationship: commentedUserRelationship, type: User.self)
    }
    
    private class func prepareObjectFromMapper<T: Identifiable>(mapper: DataIncludeMapper?, relationship: Relationship?, type: T.Type) -> T?
    {
        guard   let mapper = mapper,
                let relationship = relationship
        else { return nil }
        return mapper.objectWithIdentifier(relationship.identifier, type: T.self)
    }
}
