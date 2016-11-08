//
//  NewBubbleData.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 17.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit


@objc public enum BubbledObjectType: Int
{
    case gallery
    case creation
    case user
}

@objc
open class NewBubbleData: NSObject
{
    open let bubbledObjectIdentifier: String
    open let type: BubbledObjectType
    
    open let colorName: String?
    open let xPosition: Float?
    open let yPosition: Float?
    
    public init(userId: String)
    {
        self.bubbledObjectIdentifier = userId
        self.type = .user
        self.colorName = nil
        self.xPosition = nil
        self.yPosition = nil
    }
    
    public init(galleryId: String)
    {
        self.bubbledObjectIdentifier = galleryId
        self.type = .gallery
        self.colorName = nil
        self.xPosition = nil
        self.yPosition = nil
    }
    
    public init(creationId: String, colorName: String?, xPosition: Float?, yPosition: Float?)
    {
        self.bubbledObjectIdentifier = creationId
        self.type = .creation
        self.colorName = colorName
        self.xPosition = xPosition
        self.yPosition = yPosition
    }
}
