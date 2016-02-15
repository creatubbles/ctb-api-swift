//
//  Gallery.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 11.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class Gallery
{
    let identifier: String
    let name: String
    let createdAt: NSDate
    let updatedAt: NSDate
    let creationsCount: Int
    let bubblesCount: Int
    let commentsCount: Int
    let shortUrl: String
    let bubbledByUserIds: Array<String>
    let previewImageUrls: Array<String>
    
    let lastBubbledAt: NSDate?
    let lastCommentedAt: NSDate?
    let galleryDescription: String?
    
    init(builder: GalleryModelBuilder)
    {
        identifier = builder.identifier!
        name = builder.name!
        createdAt = builder.createdAt!
        updatedAt = builder.updatedAt!
        creationsCount = builder.creationsCount!
        bubblesCount = builder.creationsCount!
        commentsCount = builder.commentsCount!
        shortUrl = builder.shortUrl!
        bubbledByUserIds = builder.bubbledByUserIds!
        previewImageUrls = builder.previewImageUrls!
        
        lastBubbledAt = builder.lastBubbledAt
        lastCommentedAt = builder.lastCommentedAt
        galleryDescription = builder.galleryDescription
    }
}
