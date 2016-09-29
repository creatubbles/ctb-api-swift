//
//  ContentEntryMapper.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 19.05.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class ContentEntryMapper: Mappable
{
    var identifier: String?
    var type: String?
    
    var userRelationship: RelationshipMapper?
    var creationRelationship: RelationshipMapper?
    var galleryRelationship: RelationshipMapper?
    
    required init?(map: Map) { /* Intentionally left empty  */ }
    
    func mapping(map: Map)
    {
        identifier <- map["id"]
        type <- map["attributes.type"]
        
        userRelationship <- map["relationships.user.data"]
        creationRelationship <- map["relationships.creation.data"]
        galleryRelationship <- map["relationships.gallery.data"]
    }
    
    func parseCreationRelationship() -> Relationship?
    {
        return MappingUtils.relationshipFromMapper(creationRelationship)
    }
    func parseGalleryRelationship() -> Relationship?
    {
        return MappingUtils.relationshipFromMapper(galleryRelationship)
    }
    func parseUserRelationship() -> Relationship?
    {
        return MappingUtils.relationshipFromMapper(userRelationship)
    }
    
    func parseType() -> ContentEntryType
    {
        if type == "creation"   { return .creation }
        if type == "gallery"    { return .gallery  }
        if type == "user"       { return .user     }
        return .unknown
    }
}
