//
//  Creation.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 12.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

public class Creation
{
    let identifier: String
    let name: String
    let createdAt: NSDate
    let updatedAt: NSDate
    
    let createdAtYear: Int
    let createdAtMonth: Int

    let imageStatus: Int
    let image: String?
    
    let bubblesCount: Int
    let commentsCount: Int
    let viewsCount: Int
    
    let lastBubbledAt: NSDate?
    let lastCommentedAt: NSDate?
    let lastSubmittedAt: NSDate?

    let approved: Bool
    let shortUrl: String
    let createdAtAge: String
 
    init(builder: CreationModelBuilder)
    {
        identifier = builder.identifier!
        name = builder.name!
        createdAt = builder.createdAt!
        updatedAt = builder.updatedAt!
        createdAtYear = builder.createdAtYear!
        createdAtMonth = builder.createdAtMonth!
        imageStatus = builder.imageStatus!
        image = builder.image
        bubblesCount = builder.bubblesCount!
        commentsCount = builder.commentsCount!
        viewsCount = builder.viewsCount!
        lastBubbledAt = builder.lastBubbledAt
        lastCommentedAt = builder.lastCommentedAt
        lastSubmittedAt = builder.lastSubmittedAt
        approved = builder.approved!
        shortUrl = builder.shortUrl!
        createdAtAge = builder.createdAtAge!
    }
}
