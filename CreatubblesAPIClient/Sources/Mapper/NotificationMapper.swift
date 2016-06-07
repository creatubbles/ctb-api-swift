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
    
    var createdAt: NSDate?
    
    var creationRelationship: RelationshipMapper?
    var userRelationship: RelationshipMapper?
    var galleryRelationship: RelationshipMapper?
    var commentRelationship: RelationshipMapper?
    var gallerySubmissionRelationship: RelationshipMapper?
    var userEntitiesRelationship: RelationshipMapper?
    var creationEntitiesRelationship: RelationshipMapper?
    var galleryEntitiesRelationship: RelationshipMapper?
    
    var bubbleRelationship: RelationshipMapper?
    
    
    required init?(_ map: Map) { /* Intentionally left empty  */ }
    
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
        
        userEntitiesRelationship <- map["relationships.user_entities.data"]
        creationEntitiesRelationship <- map["relationships.creation_entities.data"]
        galleryEntitiesRelationship <- map["relationships.gallery_entities.data"]
        
        bubbleRelationship <- map["relationships.bubble.data"]
    }
    
    func parseType() -> NotificationType
    {
        if type == "new_submission"   { return .NewGallerySubmission }
        if type == "new_creation"     { return .NewCreation }
        if type == "new_comment"      { return .NewComment }
        if type == "bubbled_creation" { return .BubbledCreation }
        if type == "followed_creator" { return .FollowedCreator }
        
        Logger.log.warning("Unknown notification type: \(type)")
        return .Unknown
    }
}