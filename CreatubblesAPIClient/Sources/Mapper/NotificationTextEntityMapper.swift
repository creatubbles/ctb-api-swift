//
//  NotificationTextEntityMapper.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 07.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class NotificationTextEntityMapper: Mappable
{
    var identifier: String?
    var startIndex: Int?
    var endIndex: Int?
    var type: String?
    
    var userRelationship: RelationshipMapper?
    var creationRelationship: RelationshipMapper?
    var galleryRelationship: RelationshipMapper?
    
    required init?(_ map: Map) { /* Intentionally left empty  */ }
    
    func mapping(_ map: Map)
    {
        identifier <- map["id"]
        type <- map["type"]
        startIndex <- map["attributes.start_pos"]
        endIndex   <- map["attributes.end_pos"]
        
        userRelationship     <- map["relationships.user.data"]
        creationRelationship <- map["relationships.creation.data"]
        galleryRelationship  <- map["relationships.gallery.data"]
    }
    
    func parseType() -> NotificationTextEntityType
    {
        if (type == "creation_entities")    { return .creation }
        if (type == "user_entities")        { return .user}
        if (type == "gallery_entities")     { return .gallery }
        return .unknown
    }
}
