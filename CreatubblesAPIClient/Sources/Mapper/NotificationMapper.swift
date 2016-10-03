//
//  NotificationMapper.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 06.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class NotificationMapper: Mappable
{
    var identifier: String?
    var type: String?
    
    var text: String?
    var shortText: String?
    var isNew: Bool?
    
    var createdAt: Date?
    
    var creationRelationship: RelationshipMapper?
    var userRelationship: RelationshipMapper?
    var galleryRelationship: RelationshipMapper?
    var commentRelationship: RelationshipMapper?
    var gallerySubmissionRelationship: RelationshipMapper?
    
    var userEntitiesRelationships:      Array<RelationshipMapper>?
    var creationEntitiesRelationships:  Array<RelationshipMapper>?
    var galleryEntitiesRelationships:   Array<RelationshipMapper>?
    
    var bubbleRelationship: RelationshipMapper?
    
    
    required init?(map: Map) { /* Intentionally left empty  */ }
    
    func mapping(map: Map)
    {
        identifier <- map["id"]
        type <- map["attributes.type"]
        
        text <- map["attributes.text"]
        shortText <- map["attributes.short_text"]
        isNew <- map["attributes.is_new"]
        
        createdAt <- (map["attributes.created_at"], APIClientDateTransform.sharedTransform)
        
        creationRelationship <- map["relationships.creation.data"]
        userRelationship     <- map["relationships.user.data"]
        galleryRelationship  <- map["relationships.gallery.data"]
        commentRelationship  <- map["relationships.comment.data"]
        gallerySubmissionRelationship <- map["relationships.gallery_submission.data"]
        
        userEntitiesRelationships <- map["relationships.user_entities.data"]
        creationEntitiesRelationships <- map["relationships.creation_entities.data"]
        galleryEntitiesRelationships <- map["relationships.gallery_entities.data"]
        
        bubbleRelationship <- map["relationships.bubble.data"]
    }
    
    func parseType() -> NotificationType
    {
        if type == "new_submission"   { return .newGallerySubmission }
        if type == "new_creation"     { return .newCreation }
        if type == "new_comment"      { return .newComment }
        if type == "bubbled_creation" { return .bubbledCreation }
        if type == "followed_creator" { return .followedCreator }
        if type == "another_comment"  { return .anotherComment }
        if type == "new_comment_for_creation_users" { return .newCommentForCreationUsers }
        if type == "multiple_creators_created" { return .multipleCreatorsCreated }
        
        Logger.log.warning("Unknown notification type: \(self.type)")
        return .unknown
    }
}
