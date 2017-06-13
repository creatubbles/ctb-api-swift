//
//  CommentsMapper.swift
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

class CommentMapper: Mappable {
    var identifier: String?
    var text: String?
    var approved: Bool?
    var createdAt: Date?
    var commentableType: String?
    var commenterId: String?

    var commentedUserId: String?
    var commentedCreationId: String?
    var commentedGalleryId: String?

    var commenterRelationship: RelationshipMapper?
    var commentedCreationRelationship: RelationshipMapper?
    var commentedGalleryRelationship: RelationshipMapper?
    var commentedUserRelationship: RelationshipMapper?

    required init?(map: Map) { /* Intentionally left empty  */ }

    func mapping(map: Map) {
        identifier <- map["id"]
        text <- map["attributes.text"]
        approved <- map["attributes.approved"]
        createdAt <- (map["attributes.created_at"], APIClientDateTransform.sharedTransform)
        commentableType <- map["attributes.commentable_type"]
        commenterId <- map["relationships.commenter.data.id"]

        commentedUserId <- map["relationships.user.data.id"]
        commentedCreationId <- map["relationships.creation.data.id"]
        commentedGalleryId <- map["relationships.gallery.data.id"]

        commenterRelationship <- map["relationships.commenter.data"]
        commentedCreationRelationship <- map["relationships.creation.data"]
        commentedGalleryRelationship <- map["relationships.gallery.data"]
        commentedUserRelationship <- map["relationships.user.data"]
    }

    func parseCommenterRelationship() -> Relationship? {
        return MappingUtils.relationshipFromMapper(commenterRelationship)
    }
    func parseCommentedCreationRelationship() -> Relationship? {
        return MappingUtils.relationshipFromMapper(commentedCreationRelationship)
    }
    func parseCommentedGalleryRelationship() -> Relationship? {
        return MappingUtils.relationshipFromMapper(commentedGalleryRelationship)
    }
    func parseCommentedUserRelationship() -> Relationship? {
        return MappingUtils.relationshipFromMapper(commentedUserRelationship)
    }
}
