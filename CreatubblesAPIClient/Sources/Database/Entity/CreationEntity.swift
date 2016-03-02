//
//  CreationEntity.swift
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

import Foundation
import RealmSwift

class CreationEntity: Object
{
    dynamic var identifier: String?
    dynamic var name: String?
    dynamic var createdAt: NSDate?
    dynamic var updatedAt: NSDate?
    
    dynamic var imageOriginalUrl: String?
    dynamic var imageFullViewUrl: String?
    dynamic var imageListViewUrl: String?
    dynamic var imageListViewRetinaUrl: String?
    dynamic var imageMatrixViewUrl: String?
    dynamic var imageMatrixViewRetinaUrl: String?
    dynamic var imageGalleryMobileUrl: String?
    dynamic var imageExploreMobileUrl: String?
    dynamic var imageShareUrl: String?
    
    var createdAtYear = RealmOptional<Int>()
    var createdAtMonth = RealmOptional<Int>()
    
    var imageStatus = RealmOptional<Int>()
    
    var bubblesCount = RealmOptional<Int>()
    var commentsCount = RealmOptional<Int>()
    var viewsCount = RealmOptional<Int>()
    
    dynamic var lastBubbledAt: NSDate?
    dynamic var lastCommentedAt: NSDate?
    dynamic var lastSubmittedAt: NSDate?
    
    var approved = RealmOptional<Bool>()
    dynamic var shortUrl: String?
    dynamic var createdAtAge: String?
}
