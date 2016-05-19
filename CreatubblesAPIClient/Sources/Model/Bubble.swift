//
//  Bubble.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 16.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
public class Bubble: NSObject
{
    public let identifier: String
    public let xPosition: Float?
    public let yPosition: Float?
    public let colorName: String?
    public let colorHex: String?
    public let createdAt: NSDate
    public let bubblerId: String
    public let isPositionRandom: Bool
    
    public let bubbledUserId: String?
    public let bubbledCreationId: String?
    public let bubbledGalleryId: String?
    
    public let bubbler: User?
    public let bubbledCreation: Creation?
    public let bubbledGallery: Gallery?
    public let bubbledUser: User?
    
    public let bubblerRelationship: Relationship?
    public let bubbledCreationRelationship: Relationship?
    public let bubbledGalleryRelationship: Relationship?
    public let bubbledUserRelationship: Relationship?
    
    init(mapper: BubbleMapper, dataMapper: DataIncludeMapper? = nil)
    {
        identifier = mapper.identifier!
        xPosition = mapper.xPosition
        yPosition = mapper.yPosition
        colorName = mapper.colorName
        createdAt = mapper.createdAt!
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
        
        bubbler = Bubble.prepareObjectFromMapper(dataMapper, relationship: bubblerRelationship, type: User.self)
        bubbledCreation = Bubble.prepareObjectFromMapper(dataMapper, relationship: bubbledCreationRelationship, type: Creation.self)
        bubbledGallery = Bubble.prepareObjectFromMapper(dataMapper, relationship: bubbledGalleryRelationship, type: Gallery.self)
        bubbledUser = Bubble.prepareObjectFromMapper(dataMapper, relationship: bubbledUserRelationship, type: User.self)
    }
    
    private class func prepareObjectFromMapper<T: Identifiable>(mapper: DataIncludeMapper?, relationship: Relationship?, type: T.Type) -> T?
    {
        guard   let mapper = mapper,
            let relationship = relationship
            else { return nil }
        return mapper.objectWithIdentifier(relationship.identifier, type: T.self)
    }

}
