//
//  ContentEntry.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 19.05.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
public enum ContentEntryType: Int
{
    case None       //Error type, shouldn't ever happened
    case Creation
    case Gallery
    case User
}

@objc
public class ContentEntry: NSObject
{
    public let type: ContentEntryType
    public let identifier: String
    
    public let user: User?
    public let creation: Creation?
    public let gallery: Gallery?
    
    public let userRelationship: Relationship?
    public let creationRelationship: Relationship?
    public let galleryRelationship: Relationship?
    
    init(mapper: ContentEntryMapper, dataMapper: DataIncludeMapper? = nil)
    {
        identifier = mapper.identifier!
        type = mapper.parseType()
        
        userRelationship = mapper.parseUserRelationship()
        creationRelationship = mapper.parseCreationRelationship()
        galleryRelationship = mapper.parseGalleryRelationship()
        
        user = MappingUtils.objectFromMapper(dataMapper, relationship: userRelationship, type: User.self)
        creation = MappingUtils.objectFromMapper(dataMapper, relationship: creationRelationship, type: Creation.self)
        gallery = MappingUtils.objectFromMapper(dataMapper, relationship: galleryRelationship, type: Gallery.self)
    }        
}
