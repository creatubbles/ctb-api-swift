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
    
    var creationRelationship: RelationshipMapper?
    var galleryRelationship:  RelationshipMapper?
    
    required init?(_ map: Map) { /* Intentionally left empty  */ }
    
    func mapping(map: Map)
    {
        identifier  <- map["id"]
        creationRelationship <- map["relationships.creation.data"]
        galleryRelationship <- map["relationships.gallery.data"]
    }
}
