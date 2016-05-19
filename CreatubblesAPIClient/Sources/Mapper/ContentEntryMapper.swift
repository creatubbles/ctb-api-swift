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
    
    required init?(_ map: Map)
    {
        
    }
    
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
        return relationshipFromMapper(creationRelationship)
    }
    func parseGalleryRelationship() -> Relationship?
    {
        return relationshipFromMapper(galleryRelationship)
    }
    func parseUserRelationship() -> Relationship?
    {
        return relationshipFromMapper(userRelationship)
    }
    
    func parseType() -> ContentEntryType
    {
        if type == "creation"   { return .Creation }
        if type == "gallery"    { return .Gallery  }
        if type == "user"       { return .User     }
        return .None
    }
    
    private func relationshipFromMapper(mapper: RelationshipMapper?) -> Relationship?
    {
        return mapper == nil ? nil : Relationship(mapper: mapper!)
    }
    
}
