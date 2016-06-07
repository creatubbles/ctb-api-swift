//
//  Notification.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 05.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit


@objc
public class Notification: NSObject, Identifiable
{
    public let identifier: String
    public let type: NotificationType
    public let createdAt: NSDate
    
    public let bubbleRelationship: Relationship?
    public let commentRelationship: Relationship?
    public let creationRelationship: Relationship?
    public let gallerySubmissionRelationship: Relationship?
    
    public let bubble: Bubble?
    public let comment: Comment?
    public let creation: Creation?
//    public let gallery: Gallery?
    
    
    init(mapper: NotificationMapper, dataMapper: DataIncludeMapper? = nil)
    {
        identifier = mapper.identifier!
        createdAt = mapper.createdAt!
        type = mapper.parseType()
        
        bubbleRelationship = MappingUtils.relationshipFromMapper(mapper.bubbleRelationship)
        commentRelationship = MappingUtils.relationshipFromMapper(mapper.commentRelationship)
        creationRelationship = MappingUtils.relationshipFromMapper(mapper.creationRelationship)
        gallerySubmissionRelationship = MappingUtils.relationshipFromMapper(mapper.gallerySubmissionRelationship)
        
        creation = MappingUtils.objectFromMapper(dataMapper, relationship: creationRelationship, type: Creation.self)
        bubble = MappingUtils.objectFromMapper(dataMapper, relationship: bubbleRelationship, type: Bubble.self)
        comment = MappingUtils.objectFromMapper(dataMapper, relationship: commentRelationship, type: Comment.self)
    }
    
}
