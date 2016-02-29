//
//  GalleryModelBuilder.swift
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
