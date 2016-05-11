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
    var identifier: String?
    var text: String?
    var approved: Bool?
    var createdAt: NSDate?
    var commentableType: String?
    var commenterId: String?
    
    var commentedUserId: String?
    var commentedCreationId: String?
    var commentedGalleryId: String?
    
    var commenterRelationship: RelationshipMapper?
    var commentedCreationRelationship: RelationshipMapper?
    var commentedGalleryRelationship: RelationshipMapper?
    var commentedUserRelationship: RelationshipMapper?
    
    required init?(_ map: Map)
    {
        
    }
    
    func mapping(map: Map)
    {
        identifier <- map["id"]
        text <- map["attributes.text"]
        approved <- map["attributes.approved"]
        createdAt <- (map["attributes.created_at"], DateTransform())
        commentableType <- map["attributes.commentable_type"]
        commenterId <- map["relationships.commenter.data.id"]
        
        commentedUserId <- map["relationships.user.data.id"]
        commentedCreationId <- map["relationships.creation.data.id"]
        commentedGalleryId <- map["relationships.gallery.data.id"]
        
        commenterRelationship <- map["relationships.commenter.data"]
        commentedCreationRelationship <- map["relationships.creation.data"]
        commentedGalleryRelationship <- map["relationships.gallery.data"]
        commentedUserRelationship <- map["relationships.user.data"]
    }
    
    func parseCommenterRelationship() -> Relationship?
    {
        return relationshipFromMapper(commenterRelationship)
    }
    func parseCommentedCreationRelationship() -> Relationship?
    {
        return relationshipFromMapper(commentedCreationRelationship)
    }
    func parseCommentedGalleryRelationship() -> Relationship?
    {
        return relationshipFromMapper(commentedGalleryRelationship)
    }
    func parseCommentedUserRelationship() -> Relationship?
    {
        return relationshipFromMapper(commentedUserRelationship)
    }
    
    private func relationshipFromMapper(mapper: RelationshipMapper?) -> Relationship?
    {
        return mapper == nil ? nil : Relationship(mapper: mapper!)
    }
    
}
