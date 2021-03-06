//
//  CreationEntity.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2017 Creatubbles Pte. Ltd.
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

class CreatedAtAgePerCreatorDict: Object {
    dynamic var key: String?
    dynamic var value: String?
}

class CreationTagString: Object {
    dynamic var tag: String?
}

class CreationEntity: Object {
    dynamic var identifier: String?
    dynamic var name: String?
    var translatedNameEntities = List<NameTranslationObjectEntity>()
    dynamic var createdAt: Date?
    dynamic var updatedAt: Date?

    dynamic var imageOriginalUrl: String?
    dynamic var imageFullViewUrl: String?
    dynamic var imageListViewUrl: String?
    dynamic var imageListViewRetinaUrl: String?
    dynamic var imageMatrixViewUrl: String?
    dynamic var imageMatrixViewRetinaUrl: String?
    dynamic var imageGalleryMobileUrl: String?
    dynamic var imageExploreMobileUrl: String?
    dynamic var imageShareUrl: String?

    dynamic var video480Url: String?
    dynamic var video720Url: String?

    var imageStatus = RealmOptional<Int>()

    var bubblesCount = RealmOptional<Int>()
    var commentsCount = RealmOptional<Int>()
    var viewsCount = RealmOptional<Int>()
    var createdAtAgePerCreatorDict: List<CreatedAtAgePerCreatorDict>?

    dynamic var lastBubbledAt: Date?
    dynamic var lastCommentedAt: Date?
    dynamic var lastSubmittedAt: Date?

    var approved = RealmOptional<Bool>()
    dynamic var shortUrl: String?
    dynamic var createdAtAge: String?

    dynamic var reflectionText: String?
    dynamic var reflectionVideoUrl: String?

    dynamic var objFileUrl: String?
    dynamic var playIFrameUrl: String?
    var playIFrameUrlIsMobileReady = RealmOptional<Bool>()

    dynamic var contentType: String?
    var tags = List<CreationTagString>()
}
