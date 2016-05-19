//
//  Gallery.swift
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

@objc
public class Gallery: NSObject, Identifiable
{
    public let identifier: String
    public let name: String
    public let createdAt: NSDate
    public let updatedAt: NSDate
    public let creationsCount: Int
    public let bubblesCount: Int
    public let commentsCount: Int
    public let shortUrl: String
    public let previewImageUrls: Array<String>
    
    public let lastBubbledAt: NSDate?
    public let lastCommentedAt: NSDate?
    public let galleryDescription: String?
    
    //MARK: - Relationships
    public let owner: User?
    public let ownerRelationship: Relationship?
    
    init(mapper: GalleryMapper, dataMapper: DataIncludeMapper? = nil)
    {
        identifier = mapper.identifier!
        name = mapper.name!
        createdAt = mapper.createdAt!
        updatedAt = mapper.updatedAt!
        creationsCount = mapper.creationsCount!
        bubblesCount = mapper.creationsCount!
        commentsCount = mapper.commentsCount!
        shortUrl = mapper.shortUrl!
        previewImageUrls = mapper.previewImageUrls!
        
        lastBubbledAt = mapper.lastBubbledAt
        lastCommentedAt = mapper.lastCommentedAt
        galleryDescription = mapper.galleryDescription
        
        ownerRelationship = mapper.parseOwnerRelationship()
        owner = MappingUtils.objectFromMapper(dataMapper, relationship: ownerRelationship, type: User.self)                
    }
}
