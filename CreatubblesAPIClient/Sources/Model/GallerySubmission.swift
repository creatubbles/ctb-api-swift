//
//  GallerySubmission.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 07.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
public class GallerySubmission: NSObject, Identifiable
{
    public let identifier: String
    public let galleryIdentifier: String
    public let creationIdentifier: String
    
    public let creation: Creation?
    public let gallery: Gallery?
    
    public let creationRelationship: Relationship?
    public let galleryRelationship:  Relationship?
    
    
    init(mapper: GallerySubmissionMapper, dataMapper: DataIncludeMapper? = nil)
    {
        identifier = mapper.identifier!
        galleryIdentifier = mapper.galleryIdentifier!
        creationIdentifier = mapper.creationIdentifier!
        
        creationRelationship = MappingUtils.relationshipFromMapper(mapper.creationRelationship)
        galleryRelationship = MappingUtils.relationshipFromMapper(mapper.galleryRelationship)
        
        creation = MappingUtils.objectFromMapper(dataMapper, relationship: creationRelationship, type: Creation.self)
        gallery = MappingUtils.objectFromMapper(dataMapper, relationship: galleryRelationship, type: Gallery.self)
    }

}
