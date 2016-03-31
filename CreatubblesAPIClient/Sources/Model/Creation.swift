//
//  Creation.swift
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
public class Creation: NSObject
{
    public let identifier: String
    public let name: String
    public let createdAt: NSDate
    public let updatedAt: NSDate
    
    public let imageStatus: Int
    
    public let imageOriginalUrl: String?
    public let imageFullViewUrl: String?
    public let imageListViewUrl: String?
    public let imageListViewRetinaUrl: String?
    public let imageMatrixViewUrl: String?
    public let imageMatrixViewRetinaUrl: String?
    public let imageGalleryMobileUrl: String?
    public let imageExploreMobileUrl: String?
    public let imageShareUrl: String?
    
    public let bubblesCount: Int
    public let commentsCount: Int
    public let viewsCount: Int
    
    public let lastBubbledAt: NSDate?
    public let lastCommentedAt: NSDate?
    public let lastSubmittedAt: NSDate?

    public let approved: Bool
    public let shortUrl: String
    public let createdAtAge: String?

    var userRelationship: Relationship?
    var creatorRelationships: Array<Relationship>?
 
    init(mapper: CreationMapper)
    {
        identifier = mapper.identifier!
        name = mapper.name!
        createdAt = mapper.createdAt!
        updatedAt = mapper.updatedAt!
        imageStatus = mapper.imageStatus!
        bubblesCount = mapper.bubblesCount!
        commentsCount = mapper.commentsCount!
        viewsCount = mapper.viewsCount!
        lastBubbledAt = mapper.lastBubbledAt
        lastCommentedAt = mapper.lastCommentedAt
        lastSubmittedAt = mapper.lastSubmittedAt
        approved = mapper.approved!
        shortUrl = mapper.shortUrl!
        createdAtAge = mapper.createdAtAge
        
        imageOriginalUrl = mapper.imageOriginalUrl
        imageFullViewUrl = mapper.imageFullViewUrl
        imageListViewUrl = mapper.imageListViewUrl
        imageListViewRetinaUrl = mapper.imageListViewRetinaUrl
        imageMatrixViewUrl = mapper.imageMatrixViewUrl
        imageMatrixViewRetinaUrl = mapper.imageMatrixViewRetinaUrl
        imageGalleryMobileUrl = mapper.imageGalleryMobileUrl
        imageExploreMobileUrl = mapper.imageExploreMobileUrl
        imageShareUrl = mapper.imageShareUrl

        userRelationship = mapper.parseUserRelationship()
        creatorRelationships = mapper.parseCreatorRelationships()
    }
    
    init(creationEntity: CreationEntity)
    {
        identifier = creationEntity.identifier!
        name = creationEntity.name!
        createdAt = creationEntity.createdAt!
        updatedAt = creationEntity.updatedAt!
        imageStatus = creationEntity.imageStatus.value!
        bubblesCount = creationEntity.bubblesCount.value!
        commentsCount = creationEntity.commentsCount.value!
        viewsCount = creationEntity.viewsCount.value!
        lastBubbledAt = creationEntity.lastBubbledAt
        lastCommentedAt = creationEntity.lastCommentedAt
        lastSubmittedAt = creationEntity.lastSubmittedAt
        approved = creationEntity.approved.value!
        shortUrl = creationEntity.shortUrl!
        createdAtAge = creationEntity.createdAtAge
        
        imageOriginalUrl = creationEntity.imageOriginalUrl
        imageFullViewUrl = creationEntity.imageFullViewUrl
        imageListViewUrl = creationEntity.imageListViewUrl
        imageListViewRetinaUrl = creationEntity.imageListViewRetinaUrl
        imageMatrixViewUrl = creationEntity.imageMatrixViewUrl
        imageMatrixViewRetinaUrl = creationEntity.imageMatrixViewRetinaUrl
        imageGalleryMobileUrl = creationEntity.imageGalleryMobileUrl
        imageExploreMobileUrl = creationEntity.imageExploreMobileUrl
        imageShareUrl = creationEntity.imageShareUrl
    }
}
