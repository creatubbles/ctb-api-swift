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
    case unknown       //Error type, shouldn't ever happened
    case creation
    case gallery
    case user
}

@objc
open class ContentEntry: NSObject
{
    open let type: ContentEntryType
    open let identifier: String
    
    open let user: User?
    open let creation: Creation?
    open let gallery: Gallery?
    
    open let userRelationship: Relationship?
    open let creationRelationship: Relationship?
    open let galleryRelationship: Relationship?
    
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
