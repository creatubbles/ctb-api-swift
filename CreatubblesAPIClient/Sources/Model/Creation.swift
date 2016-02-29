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
    let createdAtAge: String?
 
    init(mapper: CreationMapper)
    {
        identifier = mapper.identifier!
        name = mapper.name!
        createdAt = mapper.createdAt!
        updatedAt = mapper.updatedAt!
        createdAtYear = mapper.createdAtYear!
        createdAtMonth = mapper.createdAtMonth!
        imageStatus = mapper.imageStatus!
        image = mapper.image
        bubblesCount = mapper.bubblesCount!
        commentsCount = mapper.commentsCount!
        viewsCount = mapper.viewsCount!
        lastBubbledAt = mapper.lastBubbledAt
        lastCommentedAt = mapper.lastCommentedAt
        lastSubmittedAt = mapper.lastSubmittedAt
        approved = mapper.approved!
        shortUrl = mapper.shortUrl!
        createdAtAge = mapper.createdAtAge
    }
    init(creationEntity: CreationEntity)
    {
        identifier = creationEntity.identifier!
        name = creationEntity.name!
        createdAt = creationEntity.createdAt!
        updatedAt = creationEntity.updatedAt!
        createdAtYear = creationEntity.createdAtYear.value!
        createdAtMonth = creationEntity.createdAtMonth.value!
        imageStatus = creationEntity.imageStatus.value!
        image = creationEntity.image
        bubblesCount = creationEntity.bubblesCount.value!
        commentsCount = creationEntity.commentsCount.value!
        viewsCount = creationEntity.viewsCount.value!
        lastBubbledAt = creationEntity.lastBubbledAt
        lastCommentedAt = creationEntity.lastCommentedAt
        lastSubmittedAt = creationEntity.lastSubmittedAt
        approved = creationEntity.approved.value!
        shortUrl = creationEntity.shortUrl!
        createdAtAge = creationEntity.createdAtAge!
    }
}
