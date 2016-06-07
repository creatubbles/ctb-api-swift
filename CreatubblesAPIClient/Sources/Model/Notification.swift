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
    
    public let text: String
    public let shortText: String
    public let isNew: Bool
    
    public let creationRelationship: Relationship?
    public let userRelationship: Relationship?
    public let galleryRelationship: Relationship?
    public let commentRelationship: Relationship?
    public let gallerySubmissionRelationship: Relationship?
    public let userEntitiesRelationship: Relationship?
    public let creationEntitiesRelationship: Relationship?
    public let galleryEntitiesRelationship: Relationship?
    
    public let bubbleRelationship: Relationship?

    public let bubble: Bubble?
    public let comment: Comment?
    public let creation: Creation?
    public let gallerySubmission: GallerySubmission?
    
    init(mapper: NotificationMapper, dataMapper: DataIncludeMapper? = nil)
    {
        identifier = mapper.identifier!
        text = mapper.text!
        shortText = mapper.shortText!
        isNew = mapper.isNew!
        createdAt = mapper.createdAt!
        type = mapper.parseType()
        
        bubbleRelationship = MappingUtils.relationshipFromMapper(mapper.bubbleRelationship)
        
        creationRelationship = MappingUtils.relationshipFromMapper(mapper.creationRelationship)
        userRelationship = MappingUtils.relationshipFromMapper(mapper.userRelationship)
        galleryRelationship = MappingUtils.relationshipFromMapper(mapper.galleryRelationship)
        commentRelationship = MappingUtils.relationshipFromMapper(mapper.commentRelationship)
        gallerySubmissionRelationship = MappingUtils.relationshipFromMapper(mapper.gallerySubmissionRelationship)
        userEntitiesRelationship     = MappingUtils.relationshipFromMapper(mapper.userEntitiesRelationship)
        creationEntitiesRelationship = MappingUtils.relationshipFromMapper(mapper.creationEntitiesRelationship)
        galleryEntitiesRelationship  = MappingUtils.relationshipFromMapper(mapper.galleryEntitiesRelationship)
        
        creation = MappingUtils.objectFromMapper(dataMapper, relationship: creationRelationship, type: Creation.self)
        bubble = MappingUtils.objectFromMapper(dataMapper, relationship: bubbleRelationship, type: Bubble.self)
        comment = MappingUtils.objectFromMapper(dataMapper, relationship: commentRelationship, type: Comment.self)
        gallerySubmission = MappingUtils.objectFromMapper(dataMapper, relationship: gallerySubmissionRelationship, type: GallerySubmission.self)
    }
}
