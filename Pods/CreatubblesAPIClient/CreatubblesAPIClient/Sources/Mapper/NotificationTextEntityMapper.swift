//
//  NotificationTextEntityMapper.swift
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
//

import UIKit
import ObjectMapper

class NotificationTextEntityMapper: Mappable {
    var identifier: String?
    var startIndex: Int?
    var endIndex: Int?
    var type: String?

    var userRelationship: RelationshipMapper?
    var creationRelationship: RelationshipMapper?
    var galleryRelationship: RelationshipMapper?

    required init?(map: Map) { /* Intentionally left empty  */ }

    func mapping(map: Map) {
        identifier <- map["id"]
        type <- map["type"]
        startIndex <- map["attributes.start_pos"]
        endIndex <- map["attributes.end_pos"]

        userRelationship <- map["relationships.user.data"]
        creationRelationship <- map["relationships.creation.data"]
        galleryRelationship <- map["relationships.gallery.data"]
    }

    func parseType() -> NotificationTextEntityType {
        if (type == "creation_entities") { return .creation }
        if (type == "user_entities") { return .user }
        if (type == "gallery_entities") { return .gallery }
        return .unknown
    }
}
