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
    
    init(mapper: BubbleMapper)
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
    }
}
