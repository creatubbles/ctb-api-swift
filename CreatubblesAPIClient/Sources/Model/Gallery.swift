//
//  Gallery.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 11.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
public class Gallery: NSObject
{
    public let identifier: String
    public let name: String
    public let createdAt: NSDate
    public let updatedAt: NSDate
    public let creationsCount: Int
    public let bubblesCount: Int
    public let commentsCount: Int
    public let shortUrl: String
    public let bubbledByUserIds: Array<String>
    public let previewImageUrls: Array<String>
    
    public let lastBubbledAt: NSDate?
    public let lastCommentedAt: NSDate?
    public let galleryDescription: String?
    
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
