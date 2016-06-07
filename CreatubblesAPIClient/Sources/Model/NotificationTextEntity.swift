//
//  NotificationTextEntity.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 07.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
public enum NotificationTextEntityType: Int
{
    case Unknown
    case Creation
    case Gallery
    case User
}

@objc
public class NotificationTextEntity: NSObject, Identifiable
{
    public let identifier: String
    public let startIndex: Int
    public let endIndex: Int
    public let type: NotificationTextEntityType
    
    public let user: User?
    public let creation: Creation?
    public let gallery: Gallery?
    
    public let userRelationship: Relationship?
    public let creationRelationship: Relationship?
    public let galleryRelationship: Relationship?        
        
    init(mapper: NotificationTextEntityMapper, dataMapper: DataIncludeMapper? = nil)
    {
        identifier = mapper.identifier!
        startIndex = mapper.startIndex!
        endIndex = mapper.endIndex!
        type = mapper.parseType()
        
        creationRelationship = MappingUtils.relationshipFromMapper(mapper.creationRelationship)
        galleryRelationship = MappingUtils.relationshipFromMapper(mapper.galleryRelationship)
        userRelationship = MappingUtils.relationshipFromMapper(mapper.userRelationship)
        
        creation = MappingUtils.objectFromMapper(dataMapper, relationship: creationRelationship, type: Creation.self)
        gallery = MappingUtils.objectFromMapper(dataMapper, relationship: galleryRelationship, type: Gallery.self)
        user =  MappingUtils.objectFromMapper(dataMapper, relationship: userRelationship, type: User.self)
    }
}
