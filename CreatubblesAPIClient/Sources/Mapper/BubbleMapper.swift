//
//  BubbleMapper.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 16.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class BubbleMapper: Mappable
{
    var identifier: String?
    var xPosition: Float?
    var yPosition: Float?
    var colorName: String?
    var colorHex: String?
    var createdAt: NSDate?
    var bubblerId: String?
    var isPositionRandom: Bool?
    var bubbledUserId: String?
    var bubbledCreationId: String?
    var bubbledGalleryId: String?
    
    var bubblerRelationship: RelationshipMapper?
    var bubbledCreationRelationship: RelationshipMapper?
    var bubbledGalleryRelationship: RelationshipMapper?
    var bubbledUserRelationship: RelationshipMapper?
        
    required init?(_ map: Map) { /* Intentionally left empty  */ }
    
    func mapping(map: Map)
    {
        identifier <- map["id"]
        xPosition  <- map["attributes.x_pos"]
        yPosition  <- map["attributes.y_pos"]
        colorName  <- map["attributes.color"]
        colorHex   <- map["attributes.color_hex"]
        createdAt  <- (map["attributes.created_at"], APIClientDateTransform.sharedTransform)
        bubblerId  <- map["relationships.bubbler.data.id"]
        isPositionRandom <- map["data.attributes.random_pos"]
                
        bubbledUserId     <- map["relationships.user.data.id"]
        bubbledCreationId <- map["relationships.creation.data.id"]
        bubbledGalleryId  <- map["relationships.gallery.data.id"]
        
        bubblerRelationship <- map["relationships.bubbler.data"]
        bubbledCreationRelationship <- map["relationships.creation.data"]
        bubbledGalleryRelationship <- map["relationships.gallery.data"]
        bubbledUserRelationship <- map["relationships.user.data"]
    }
    
    func parseBubblerRelationship() -> Relationship?
    {
        return MappingUtils.relationshipFromMapper(bubblerRelationship)
    }
    func parseBubbledCreationRelationship() -> Relationship?
    {
        return MappingUtils.relationshipFromMapper(bubbledCreationRelationship)
    }
    func parseBubbledGalleryRelationship() -> Relationship?
    {
        return MappingUtils.relationshipFromMapper(bubbledGalleryRelationship)
    }
    func parseBubbledUserRelationship() -> Relationship?
    {
        return MappingUtils.relationshipFromMapper(bubbledUserRelationship)
    }        
}
