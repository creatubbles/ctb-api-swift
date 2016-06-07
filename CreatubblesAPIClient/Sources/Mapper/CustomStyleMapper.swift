//
//  CustomStyleMapper.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class CustomStyleMapper: Mappable
{
    var identifier: String?
    var headerBackgroundIdentifier: String?
    var bodyBackgroundIdentifier: String?
    var fontName: String?
    var bio: String?
    var bodyColorsHex: Array<String>?
    var headerColorsHex: Array<String>?
    var bodyCreationURL: String?
    var headerCreationURL: String?
    
    var createdAt: NSDate?
    var updatedAt: NSDate?
    
    var userRelationship: RelationshipMapper?
    var headerCreationRelationship: RelationshipMapper?
    var bodyCreationRelationship: RelationshipMapper?
    
    required init?(_ map: Map) { /* Intentionally left empty  */ }
    
    func mapping(map: Map)
    {
        identifier <- map["id"]
        
        headerBackgroundIdentifier <- map["attributes.header_background_id"]
        bodyBackgroundIdentifier <- map["attributes.body_background_id"]
        fontName <- map["attributes.font"]
        bio <- map["attributes.bio"]        
        bodyColorsHex <- map["attributes.body_colors"]
        headerColorsHex <- map["attributes.header_colors"]
        bodyCreationURL <- map["attributes.body_creation_url"]
        headerCreationURL <- map["attributes.header_creation_url"]
        
        createdAt <- (map["attributes.created_at"], APIClientDateTransform.sharedTransform)
        updatedAt <- (map["attributes.updated_at"], APIClientDateTransform.sharedTransform)
        
        userRelationship <- map["relationships.user.data"]
        headerCreationRelationship <- map["relationships.header_creation.data"]
        bodyCreationRelationship <- map["relationships.body_creation.data"]
    }
}
