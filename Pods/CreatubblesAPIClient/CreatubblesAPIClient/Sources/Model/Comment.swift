//
//  Comment.swift
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

@objc
open class Comment: NSObject, Identifiable {
    open var identifier: String
    open var text: String
    open var approved: Bool
    open var createdAt: Date
    open var commentableType: String
    open var commenterId: String

    open let commentedUserId: String?
    open let commentedCreationId: String?
    open let commentedGalleryId: String?

    open let commenter: User?
    open let commentedCreation: Creation?
    open let commentedGallery: Gallery?
    open let commentedUser: User?

    open let commenterRelationship: Relationship?
    open let commentedCreationRelationship: Relationship?
    open let commentedGalleryRelationship: Relationship?
    open let commentedUserRelationship: Relationship?

    open let abilities: Array<Ability>

    init(mapper: CommentMapper, dataMapper: DataIncludeMapper? = nil, metadata: Metadata? = nil) {
        identifier = mapper.identifier!
        text = mapper.text!
        approved = mapper.approved!
        createdAt = mapper.createdAt! as Date
        commentableType = mapper.commentableType!
        commenterId = mapper.commenterId!

        commentedUserId = mapper.commentedUserId
        commentedCreationId = mapper.commentedCreationId
        commentedGalleryId = mapper.commentedGalleryId

        commenterRelationship = mapper.parseCommenterRelationship()
        commentedCreationRelationship = mapper.parseCommentedCreationRelationship()
        commentedGalleryRelationship = mapper.parseCommentedGalleryRelationship()
        commentedUserRelationship = mapper.parseCommentedUserRelationship()

        commenter = MappingUtils.objectFromMapper(dataMapper, relationship: commenterRelationship, type: User.self)
        commentedCreation = MappingUtils.objectFromMapper(dataMapper, relationship: commentedCreationRelationship, type: Creation.self)
        commentedGallery = MappingUtils.objectFromMapper(dataMapper, relationship: commentedGalleryRelationship, type: Gallery.self)
        commentedUser = MappingUtils.objectFromMapper(dataMapper, relationship: commentedUserRelationship, type: User.self)

        abilities = MappingUtils.abilitiesFrom(metadata: metadata, forObjectWithIdentifier: identifier)
    }
}
