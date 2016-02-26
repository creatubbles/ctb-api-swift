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
        createdAtAge = builder.createdAtAge
    }
}
