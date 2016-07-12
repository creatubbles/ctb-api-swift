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
    
    public let creation: Creation?
    public let user: User?
    public let gallery: Gallery?
    public let comment: Comment?
    public let gallerySubmission: GallerySubmission?
    public let userEntities:     Array<NotificationTextEntity>?
    public let creationEntities: Array<NotificationTextEntity>?
    public let galleryEntities:  Array<NotificationTextEntity>?
    
    public let creationRelationship: Relationship?
    public let userRelationship: Relationship?
    public let galleryRelationship: Relationship?
    public let commentRelationship: Relationship?
    public let gallerySubmissionRelationship: Relationship?
    public let userEntitiesRelationships:     Array<Relationship>?
    public let creationEntitiesRelationships: Array<Relationship>?
    public let galleryEntitiesRelationships:  Array<Relationship>?
    
    public let bubbleRelationship: Relationship?
    public let bubble: Bubble?
    
    //MARK: - Metadata
    public let totalUnreadCount: Int?
    
    init(mapper: NotificationMapper, dataMapper: DataIncludeMapper? = nil, notificationMetadata: NotificationMetadata? = nil)
    {
        identifier = mapper.identifier!
        text = mapper.text!
        shortText = mapper.shortText!
        isNew = mapper.isNew!
        createdAt = mapper.createdAt!
        type = mapper.parseType()        
        
        creationRelationship = MappingUtils.relationshipFromMapper(mapper.creationRelationship)
        userRelationship = MappingUtils.relationshipFromMapper(mapper.userRelationship)
        galleryRelationship = MappingUtils.relationshipFromMapper(mapper.galleryRelationship)
        commentRelationship = MappingUtils.relationshipFromMapper(mapper.commentRelationship)
        gallerySubmissionRelationship = MappingUtils.relationshipFromMapper(mapper.gallerySubmissionRelationship)
        
        userEntitiesRelationships     = mapper.userEntitiesRelationships?.flatMap({ MappingUtils.relationshipFromMapper($0) })
        creationEntitiesRelationships = mapper.creationEntitiesRelationships?.flatMap({ MappingUtils.relationshipFromMapper($0) })
        galleryEntitiesRelationships  = mapper.galleryEntitiesRelationships?.flatMap({ MappingUtils.relationshipFromMapper($0) })
        
        creation = MappingUtils.objectFromMapper(dataMapper, relationship: creationRelationship, type: Creation.self)
        user = MappingUtils.objectFromMapper(dataMapper, relationship: userRelationship, type: User.self)
        gallery = MappingUtils.objectFromMapper(dataMapper, relationship: galleryRelationship, type: Gallery.self)
        comment = MappingUtils.objectFromMapper(dataMapper, relationship: commentRelationship, type: Comment.self)
        gallerySubmission = MappingUtils.objectFromMapper(dataMapper, relationship: gallerySubmissionRelationship, type: GallerySubmission.self)
        
        userEntities = userEntitiesRelationships?.flatMap({ MappingUtils.objectFromMapper(dataMapper, relationship: $0, type: NotificationTextEntity.self) }).filter({ $0.type != .Unknown })
        creationEntities = creationEntitiesRelationships?.flatMap({ MappingUtils.objectFromMapper(dataMapper, relationship: $0, type: NotificationTextEntity.self) }).filter({ $0.type != .Unknown })
        galleryEntities = galleryEntitiesRelationships?.flatMap({ MappingUtils.objectFromMapper(dataMapper, relationship: $0, type: NotificationTextEntity.self) }).filter({ $0.type != .Unknown })
        
        //Not sure if we still need this?
        bubbleRelationship = MappingUtils.relationshipFromMapper(mapper.bubbleRelationship)
        bubble = MappingUtils.objectFromMapper(dataMapper, relationship: bubbleRelationship, type: Bubble.self)
        
        totalUnreadCount = notificationMetadata?.totalUnreadCount ?? 0
    }
}
