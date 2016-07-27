//
//  Activity.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 22.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
public class Activity: NSObject, Identifiable
{
    public let identifier: String
    public let type: ActivityType
    public let count: Int
    public let itemsCount: Int
    
    public let createdAt: NSDate
    public let lastUpdatedAt: NSDate
    
    public let owners: Array<User>?
    public let creation: Creation?
    public let gallery: Gallery?
    public let user: User?
    public let relatedCreations: Array<Creation>?
    public let relatedComments: Array<Comment>?
    
    public let ownersRelationships: Array<Relationship>?
    public let creationRelationship: Relationship?
    public let galleryRelationship: Relationship?
    public let userRelationship: Relationship?
    public let relatedCreationsRelationships: Array<Relationship>?
    public let relatedCommentsRelationships: Array<Relationship>?
    
    init(mapper: ActivityMapper, dataMapper: DataIncludeMapper? = nil, metadata: Metadata? = nil) {
        identifier = mapper.identifier!
        type = mapper.parseType()
        
        count = mapper.count!
        itemsCount = mapper.itemsCount!
        
        createdAt = mapper.createdAt!
        lastUpdatedAt = mapper.lastUpdatedAt!
        
        ownersRelationships  = mapper.ownersRelationships?.flatMap({ MappingUtils.relationshipFromMapper($0) })
        creationRelationship = MappingUtils.relationshipFromMapper(mapper.creationRelationship)
        galleryRelationship = MappingUtils.relationshipFromMapper(mapper.galleryRelationship)
        userRelationship = MappingUtils.relationshipFromMapper(mapper.userRelationship)
        
        relatedCreationsRelationships = mapper.relatedCreationsRelationships?.flatMap({ MappingUtils.relationshipFromMapper($0) })
        relatedCommentsRelationships = mapper.relatedCommentsRelationships?.flatMap({ MappingUtils.relationshipFromMapper($0) })
        
        owners = ownersRelationships?.flatMap({ MappingUtils.objectFromMapper(dataMapper, relationship: $0, type: User.self) })
        creation = MappingUtils.objectFromMapper(dataMapper, relationship: creationRelationship, type: Creation.self)
        user = MappingUtils.objectFromMapper(dataMapper, relationship: userRelationship, type: User.self)
        gallery = MappingUtils.objectFromMapper(dataMapper, relationship: galleryRelationship, type: Gallery.self)
        
        relatedCreations = relatedCreationsRelationships?.flatMap({ MappingUtils.objectFromMapper(dataMapper, relationship: $0, type: Creation.self) })
        relatedComments = relatedCommentsRelationships?.flatMap({ MappingUtils.objectFromMapper(dataMapper, relationship: $0, type: Comment.self) })
    }
}