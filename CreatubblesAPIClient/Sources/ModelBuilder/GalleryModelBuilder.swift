//
//  GalleryModelBuilder.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 11.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class GalleryModelBuilder: Mappable
{
    var identifier: String?
    var name: String?
    var galleryDescription: String?
    var createdAt: NSDate?
    var updatedAt: NSDate?
    var lastBubbledAt: NSDate?
    var lastCommentedAt: NSDate?
    var creationsCount: Int?
    var bubblesCount: Int?
    var commentsCount: Int?
    var shortUrl: String?
    var bubbledByUserIds: Array<String>?
    var previewImageUrls: Array<String>?
    
    required init?(_ map: Map)
    {
        
    }
    
    func mapping(map: Map)
    {
        identifier  <- map["id"]
        name <- map["attributes.name"]
        galleryDescription <- map["attributes.description"]
        createdAt <- (map["attributes.created_at"], DateTransform())
        updatedAt <- (map["attributes.updated_at"], DateTransform())
        lastBubbledAt <- (map["attributes.last_bubbled_at"], DateTransform())
        lastCommentedAt <- (map["attributes.last_commented_at"], DateTransform())
        commentsCount <- map["attributes.comments_count"]
        creationsCount <- map["attributes.creations_count"]
        bubblesCount <- map["attributes.bubbles_count"]
        shortUrl <- map["attributes.short_url"]
        bubbledByUserIds <- map["attributes.bubbled_by_user_ids"]
        previewImageUrls <- map["attributes.preview_image_urls"]
    }
}
