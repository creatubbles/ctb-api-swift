//
//  Comment.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 17.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
open class Comment: NSObject, Identifiable
{
    open var identifier: String
    open var text: String
    open var approved: Bool
    open var createdAt: Date
    open var commentableType: String
    open var commenterId: String
    
    open let commentedUserId: String?
    open let commentedCreationId: String?
    open let commentedGalleryId: String?
    
    open let commenter: User?
    open let commentedCreation: Creation?
    open let commentedGallery: Gallery?
    open let commentedUser: User?
    
    open let commenterRelationship: Relationship?
    open let commentedCreationRelationship: Relationship?
    open let commentedGalleryRelationship: Relationship?
    open let commentedUserRelationship: Relationship?
    
    open let abilities: Array<Ability>
    
    init(mapper: CommentMapper, dataMapper: DataIncludeMapper? = nil, metadata: Metadata? = nil)
    {
        identifier = mapper.identifier!
        text = mapper.text!
        approved = mapper.approved!
        createdAt = mapper.createdAt! as Date
        commentableType = mapper.commentableType!
        commenterId = mapper.commenterId!
        
        commentedUserId = mapper.commentedUserId
        commentedCreationId = mapper.commentedCreationId
        commentedGalleryId = mapper.commentedGalleryId
        
        commenterRelationship = mapper.parseCommenterRelationship()
        commentedCreationRelationship = mapper.parseCommentedCreationRelationship()
        commentedGalleryRelationship = mapper.parseCommentedGalleryRelationship()
        commentedUserRelationship = mapper.parseCommentedUserRelationship()
        
        commenter = MappingUtils.objectFromMapper(dataMapper, relationship: commenterRelationship, type: User.self)
        commentedCreation = MappingUtils.objectFromMapper(dataMapper, relationship: commentedCreationRelationship, type: Creation.self)
        commentedGallery = MappingUtils.objectFromMapper(dataMapper, relationship: commentedGalleryRelationship, type: Gallery.self)
        commentedUser = MappingUtils.objectFromMapper(dataMapper, relationship: commentedUserRelationship, type: User.self)
        
        abilities = metadata?.abilities.filter({ $0.resourceIdentifier == mapper.identifier! }) ?? []
        
    }
}
