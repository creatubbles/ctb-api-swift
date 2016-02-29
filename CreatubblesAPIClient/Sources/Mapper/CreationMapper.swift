//
//  CreationMapper.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2016 Creatubbles Pte. Ltd.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit
import ObjectMapper

class CreationMapper: Mappable
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
