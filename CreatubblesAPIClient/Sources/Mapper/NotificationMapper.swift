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
    var createdAt: NSDate?
    
    var bubbleRelationship: RelationshipMapper?
    var commentRelationship: RelationshipMapper?
    var creationRelationship: RelationshipMapper?
    var gallerySubmissionRelationship: RelationshipMapper?
    
    required init?(_ map: Map)
    {
        
    }
    
    func mapping(map: Map)
    {
        identifier <- map["id"]
        type <- map["attributes.type"]
        createdAt <- (map["attributes.created_at"], APIClientDateTransform.sharedTransform)
        
        bubbleRelationship <- map["relationships.bubble.data"]
        commentRelationship <- map["relationships.comment.data"]
        creationRelationship <- map["relationships.creation.data"]
        gallerySubmissionRelationship <- map["relationships.gallery_submission.data"]
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