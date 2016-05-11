//
//  BubbleMapper.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 16.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class BubbleMapper: Mappable
{
    var identifier: String?
    var xPosition: Float?
    var yPosition: Float?
    var colorName: String?
    var colorHex: String?
    var createdAt: NSDate?
    var bubblerId: String?
    var isPositionRandom: Bool?
    var bubbledUserId: String?
    var bubbledCreationId: String?
    var bubbledGalleryId: String?
    
    required init?(_ map: Map)
    {
        
    }
    
    func mapping(map: Map)
    {
        identifier <- map["id"]
        xPosition  <- map["attributes.x_pos"]
        yPosition  <- map["attributes.y_pos"]
        colorName  <- map["attributes.color"]
        colorHex   <- map["attributes.color_hex"]
        createdAt  <- (map["attributes.created_at"], APIClientDateTransform.sharedTransform)
        bubblerId  <- map["relationships.bubbler.data.id"]
        isPositionRandom <- map["data.attributes.random_pos"]
        
        
        bubbledUserId     <- map["relationships.user.data.id"]
        bubbledCreationId <- map["relationships.creation.data.id"]
        bubbledGalleryId  <- map["relationships.gallery.data.id"]
    }
}
