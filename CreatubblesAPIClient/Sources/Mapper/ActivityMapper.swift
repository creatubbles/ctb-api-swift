//
//  ActivityMapper.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 22.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class ActivityMapper: Mappable {
    var identifier: String?
    var type: String?
    var count: Int?
    var itemsCount: Int?
    
    var createdAt: NSDate?
    var lastUpdatedAt: NSDate?
    
    var ownersRelationships: Array<RelationshipMapper>?
    var creationRelationship: RelationshipMapper?
    var galleryRelationship: RelationshipMapper?
    var userRelationship: RelationshipMapper?
    var relatedCreationsRelationships: Array<RelationshipMapper>?
    var relatedCommentsRelationships: Array<RelationshipMapper>?
    
    required init?(_ map: Map) { /* Intentionally left empty  */ }
    
    func mapping(map: Map) {
        identifier <- map["id"]
        type <- map["attributes.key"]
        
        count <- map["attributes.count"]
        itemsCount <- map["attributes.items_count"]
        
        createdAt <- (map["attributes.created_at"], APIClientShortDateTransform.sharedTransform)
        lastUpdatedAt <- (map["attributes.last_updated_at"], APIClientDateTransform.sharedTransform)
        
        ownersRelationships <- map["relationships.owners.data"]
        creationRelationship <- map["relationships.creation.data"]
        galleryRelationship <- map["relationships.gallery.data"]
        userRelationship <- map["relationships.user.data"]
        relatedCreationsRelationships <- map["relationships.related_creations.data"]
        relatedCommentsRelationships <- map["relationships.related_comments.data"]
    }
    
    func parseType() -> ActivityType {
        if type == "creation.bubbled" { return .CreationBubbled }
        if type == "creation.commented" { return .CreationCommented }
        if type == "creation.published" { return .CreationPublished }
        if type == "gallery.bubbled" { return .GalleryBubbled }
        if type == "gallery.commented" { return .GalleryCommented }
        if type == "gallery.creation_added" { return .GalleryCreationAdded }
        if type == "user.bubbled" { return .UserBubbled }
        if type == "user.commented" { return .UserCommented }
        
        Logger.log.warning("Unknown activity type: \(type)")
        return .Unknown
    }
}