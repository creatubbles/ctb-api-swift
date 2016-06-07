//
//  GallerySubmissionMapper.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 07.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class GallerySubmissionMapper: Mappable
{
    var identifier: String?
    
    var galleryIdentifier: String?
    var creationIdentifier: String?
    
    var creationRelationship: RelationshipMapper?
    var galleryRelationship:  RelationshipMapper?
    
    required init?(_ map: Map) { /* Intentionally left empty  */ }
    
    func mapping(map: Map)
    {
        identifier  <- map["id"]
        galleryIdentifier  <- map["attributes.gallery_id"]
        creationIdentifier <- map["attributes.creation_id"]

        creationRelationship <- map["relationships.creation.data"]
        galleryRelationship <- map["relationships.gallery.data"]
    }
}
