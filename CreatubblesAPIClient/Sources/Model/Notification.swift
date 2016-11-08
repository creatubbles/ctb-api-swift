//
//  Notification.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 05.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
open class Notification: NSObject, Identifiable
{
    open let identifier: String
    open let type: NotificationType
    open let createdAt: Date
    
    open let text: String
    open let shortText: String
    open let isNew: Bool
    
    open let creation: Creation?
    open let user: User?
    open let gallery: Gallery?
    open let comment: Comment?
    open let gallerySubmission: GallerySubmission?
    open let userEntities:     Array<NotificationTextEntity>?
    open let creationEntities: Array<NotificationTextEntity>?
    open let galleryEntities:  Array<NotificationTextEntity>?
    
    open let creationRelationship: Relationship?
    open let userRelationship: Relationship?
    open let galleryRelationship: Relationship?
    open let commentRelationship: Relationship?
    open let gallerySubmissionRelationship: Relationship?
    open let userEntitiesRelationships:     Array<Relationship>?
    open let creationEntitiesRelationships: Array<Relationship>?
    open let galleryEntitiesRelationships:  Array<Relationship>?
    
    open let bubbleRelationship: Relationship?
    open let bubble: Bubble?
    
    init(mapper: NotificationMapper, dataMapper: DataIncludeMapper? = nil)
    {
        identifier = mapper.identifier!
        text = mapper.text!
        shortText = mapper.shortText!
        isNew = mapper.isNew!
        createdAt = mapper.createdAt! as Date
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
        
        userEntities = userEntitiesRelationships?.flatMap({ MappingUtils.objectFromMapper(dataMapper, relationship: $0, type: NotificationTextEntity.self) }).filter({ $0.type != .unknown })
        creationEntities = creationEntitiesRelationships?.flatMap({ MappingUtils.objectFromMapper(dataMapper, relationship: $0, type: NotificationTextEntity.self) }).filter({ $0.type != .unknown })
        galleryEntities = galleryEntitiesRelationships?.flatMap({ MappingUtils.objectFromMapper(dataMapper, relationship: $0, type: NotificationTextEntity.self) }).filter({ $0.type != .unknown })
        
        //Not sure if we still need this?
        bubbleRelationship = MappingUtils.relationshipFromMapper(mapper.bubbleRelationship)
        bubble = MappingUtils.objectFromMapper(dataMapper, relationship: bubbleRelationship, type: Bubble.self)
    }
}
