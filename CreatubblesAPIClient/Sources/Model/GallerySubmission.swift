//
//  GallerySubmission.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 07.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
open class GallerySubmission: NSObject, Identifiable
{
    open let identifier: String
    
    open let creation: Creation?
    open let gallery: Gallery?
    
    open let creationRelationship: Relationship?
    open let galleryRelationship:  Relationship?
    
    init(mapper: GallerySubmissionMapper, dataMapper: DataIncludeMapper? = nil)
    {
        identifier = mapper.identifier!    
        
        creationRelationship = MappingUtils.relationshipFromMapper(mapper.creationRelationship)
        galleryRelationship = MappingUtils.relationshipFromMapper(mapper.galleryRelationship)
        
        creation = MappingUtils.objectFromMapper(dataMapper, relationship: creationRelationship, type: Creation.self)
        gallery = MappingUtils.objectFromMapper(dataMapper, relationship: galleryRelationship, type: Gallery.self)
    }
}
