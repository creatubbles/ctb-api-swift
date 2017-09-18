//
//  ActivityMapper.swift
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

class ActivityMapper: Mappable {
    var identifier: String?
    var type: String?
    var count: Int?
    var itemsCount: Int?

    var createdAt: Date?
    var lastUpdatedAt: Date?

    var ownersRelationships: Array<RelationshipMapper>?
    var creationRelationship: RelationshipMapper?
    var galleryRelationship: RelationshipMapper?
    var userRelationship: RelationshipMapper?
    var relatedCreationsRelationships: Array<RelationshipMapper>?
    var relatedCommentsRelationships: Array<RelationshipMapper>?

    required init?(map: Map) { /* Intentionally left empty  */ }

    func mapping(map: Map) {
        identifier <- map["id"]
        type <- map["attributes.key"]

        count <- map["attributes.count"]
        itemsCount <- map["attributes.items_count"]

        createdAt <- (map["attributes.created_at"], APIClientShortDateTransform.sharedTransform)
        lastUpdatedAt <- (map["attributes.last_updated_at"], APIClientDateTransform.sharedTransform)

        ownersRelationships <- map["relationships.owners.data"]
        creationRelationship <- map["relationships.creation.data"]
        galleryRelationship <- map["relationships.gallery.data"]
        userRelationship <- map["relationships.user.data"]
        relatedCreationsRelationships <- map["relationships.related_creations.data"]
        relatedCommentsRelationships <- map["relationships.related_comments.data"]
    }

    func parseType() -> ActivityType {
        if type == "creation.bubbled" { return .creationBubbled }
        if type == "creation.commented" { return .creationCommented }
        if type == "creation.published" { return .creationPublished }
        if type == "gallery.bubbled" { return .galleryBubbled }
        if type == "gallery.commented" { return .galleryCommented }
        if type == "gallery.creation_added" { return .galleryCreationAdded }
        if type == "user.bubbled" { return .userBubbled }
        if type == "user.commented" { return .userCommented }

        Logger.log(.warning, "Unknown activity type: \(String(describing: self.type))")
        return .unknown
    }
}
