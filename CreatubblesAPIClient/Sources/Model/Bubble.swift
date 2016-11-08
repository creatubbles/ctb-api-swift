//
//  Bubble.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 16.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
open class Bubble: NSObject, Identifiable
{
    open let identifier: String
    open let xPosition: Float?
    open let yPosition: Float?
    open let colorName: String?
    open let colorHex: String?
    open let createdAt: Date
    open let bubblerId: String
    open let isPositionRandom: Bool
    
    open let bubbledUserId: String?
    open let bubbledCreationId: String?
    open let bubbledGalleryId: String?
    
    open let bubbler: User?
    open let bubbledCreation: Creation?
    open let bubbledGallery: Gallery?
    open let bubbledUser: User?
    
    open let bubblerRelationship: Relationship?
    open let bubbledCreationRelationship: Relationship?
    open let bubbledGalleryRelationship: Relationship?
    open let bubbledUserRelationship: Relationship?
    
    open let abilities: Array<Ability>
    
    init(mapper: BubbleMapper, dataMapper: DataIncludeMapper? = nil, metadata: Metadata? = nil)
    {
        identifier = mapper.identifier!
        xPosition = mapper.xPosition
        yPosition = mapper.yPosition
        colorName = mapper.colorName
        createdAt = mapper.createdAt! as Date
        bubblerId = mapper.bubblerId!
        isPositionRandom = mapper.isPositionRandom ?? false
        colorHex = mapper.colorHex
        
        bubbledUserId = mapper.bubbledUserId
        bubbledCreationId = mapper.bubbledCreationId
        bubbledGalleryId = mapper.bubbledGalleryId
        
        bubblerRelationship = mapper.parseBubblerRelationship()
        bubbledCreationRelationship = mapper.parseBubbledCreationRelationship()
        bubbledGalleryRelationship = mapper.parseBubbledGalleryRelationship()
        bubbledUserRelationship = mapper.parseBubbledUserRelationship()
        
        bubbler = MappingUtils.objectFromMapper(dataMapper, relationship: bubblerRelationship, type: User.self)
        bubbledCreation = MappingUtils.objectFromMapper(dataMapper, relationship: bubbledCreationRelationship, type: Creation.self)
        bubbledGallery = MappingUtils.objectFromMapper(dataMapper, relationship: bubbledGalleryRelationship, type: Gallery.self)
        bubbledUser = MappingUtils.objectFromMapper(dataMapper, relationship: bubbledUserRelationship, type: User.self)
        
        abilities = metadata?.abilities.filter({ $0.resourceIdentifier == mapper.identifier! }) ?? []
    }
}
