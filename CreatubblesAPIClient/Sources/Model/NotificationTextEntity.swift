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
    case unknown
    case creation
    case gallery
    case user
}

@objc
open class NotificationTextEntity: NSObject, Identifiable
{
    open let identifier: String
    open let startIndex: Int
    open let endIndex: Int
    open let type: NotificationTextEntityType
    
    open let user: User?
    open let creation: Creation?
    open let gallery: Gallery?
    
    open let userRelationship: Relationship?
    open let creationRelationship: Relationship?
    open let galleryRelationship: Relationship?        
        
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
