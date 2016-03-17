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
    case Gallery
    case Creation
    case User
}

@objc
public class NewBubbleData: NSObject
{
    public let bubbledObjectIdentifier: String
    public let type: BubbledObjectType
    
    public let colorName: String?
    public let xPosition: Float?
    public let yPosition: Float?
    
    public init(userId: String)
    {
        self.bubbledObjectIdentifier = userId
        self.type = .User
        self.colorName = nil
        self.xPosition = nil
        self.yPosition = nil
    }
    
    public init(galleryId: String)
    {
        self.bubbledObjectIdentifier = galleryId
        self.type = .Gallery
        self.colorName = nil
        self.xPosition = nil
        self.yPosition = nil
    }
    
    public init(creationId: String, colorName: String?, xPosition: Float?, yPosition: Float?)
    {
        self.bubbledObjectIdentifier = creationId
        self.type = .Creation
        self.colorName = colorName
        self.xPosition = xPosition
        self.yPosition = yPosition
    }
}
