//
//  NotificationMapper.swift
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

class NotificationMapper: Mappable
{
    var identifier: String?
    var type: String?
    
    var text: String?
    var shortText: String?
    var isNew: Bool?
    
    var createdAt: Date?
    
    var creationRelationship: RelationshipMapper?
    var userRelationship: RelationshipMapper?
    var galleryRelationship: RelationshipMapper?
    var commentRelationship: RelationshipMapper?
    var gallerySubmissionRelationship: RelationshipMapper?
    
    var userEntitiesRelationships:      Array<RelationshipMapper>?
    var creationEntitiesRelationships:  Array<RelationshipMapper>?
    var galleryEntitiesRelationships:   Array<RelationshipMapper>?
    
    var bubbleRelationship: RelationshipMapper?
    
    
    required init?(map: Map) { /* Intentionally left empty  */ }
    
    func mapping(map: Map)
    {
        identifier <- map["id"]
        type <- map["attributes.type"]
        
        text <- map["attributes.text"]
        shortText <- map["attributes.short_text"]
        isNew <- map["attributes.is_new"]
        
        createdAt <- (map["attributes.created_at"], APIClientDateTransform.sharedTransform)
        
        creationRelationship <- map["relationships.creation.data"]
        userRelationship     <- map["relationships.user.data"]
        galleryRelationship  <- map["relationships.gallery.data"]
        commentRelationship  <- map["relationships.comment.data"]
        gallerySubmissionRelationship <- map["relationships.gallery_submission.data"]
        
        userEntitiesRelationships <- map["relationships.user_entities.data"]
        creationEntitiesRelationships <- map["relationships.creation_entities.data"]
        galleryEntitiesRelationships <- map["relationships.gallery_entities.data"]
        
        bubbleRelationship <- map["relationships.bubble.data"]
    }
    
    func parseType() -> NotificationType
    {
        if type == "new_submission"   { return .newGallerySubmission }
        if type == "new_creation"     { return .newCreation }
        if type == "new_comment"      { return .newComment }
        if type == "bubbled_creation" { return .bubbledCreation }
        if type == "followed_creator" { return .followedCreator }
        if type == "another_comment"  { return .anotherComment }
        if type == "new_comment_for_creation_users" { return .newCommentForCreationUsers }
        if type == "multiple_creators_created" { return .multipleCreatorsCreated }
        if type == "translation_tip" { return .translationTip }
        if type == "customize_tip" { return .customizeTip }
        if type == "galleries_tip" { return .galleriesTip }
        if type == "bubbles_tip" { return .bubblesTip }
        
        Logger.log(.warning, "Unknown notification type: \(self.type)")
        return .unknown
    }
}
