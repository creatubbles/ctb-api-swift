//
//  CreationModelBuilder.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 12.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class CreationModelBuilder: Mappable
{
    var identifier: String?
    var name: String?
    var createdAt: NSDate?
    var updatedAt: NSDate?
    
    var createdAtYear: Int?
    var createdAtMonth: Int?
    
    var imageStatus: Int?
    var image: String?
    
    
    var bubblesCount: Int?
    var commentsCount: Int?
    var viewsCount: Int?
    
    var lastBubbledAt: NSDate?
    var lastCommentedAt: NSDate?
    var lastSubmittedAt: NSDate?
    
    var approved: Bool?
    var shortUrl: String?
    var createdAtAge: String?
    
    required init?(_ map: Map)
    {
        
    }
    
    func mapping(map: Map)
    {
        identifier  <- map["id"]
        name <- map["attributes.name"]
        createdAt <- (map["attributes.created_at"], DateTransform())
        updatedAt <- (map["attributes.updated_at"], DateTransform())
        
        createdAtYear <- map["attributes.created_at_year"]
        createdAtMonth <- map["attributes.created_at_month"]
        
        imageStatus <- map["attributes.image_status"]
        image <- map["attributes.image"]
        
        bubblesCount <- map["attributes.bubbles_count"]
        commentsCount <- map["attributes.comments_count"]
        viewsCount <- map["attributes.views_count"]
        
        lastBubbledAt <- (map["attributes.last_bubbled_at"], DateTransform())
        lastCommentedAt <- (map["attributes.last_commented_at"], DateTransform())
        lastSubmittedAt <- (map["attributes.last_submitted_at"], DateTransform())
        
        approved <- map["attributes.approved"]
        shortUrl <- map["attributes.short_url"]
        createdAtAge <- map["attributes.created_at_age"]
    }
}
