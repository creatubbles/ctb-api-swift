//
//  CreationMapper.swift
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
import ObjectMapper

class CreationMapper: Mappable
{
    var identifier: String?
    var name: String?
    var createdAt: NSDate?
    var updatedAt: NSDate?
    var imageStatus: Int?
    
    var imageOriginalUrl: String?
    var imageFullViewUrl: String?
    var imageListViewUrl: String?
    var imageListViewRetinaUrl: String?
    var imageMatrixViewUrl: String?
    var imageMatrixViewRetinaUrl: String?
    var imageGalleryMobileUrl: String?
    var imageExploreMobileUrl: String?
    var imageShareUrl: String?
    
    var video480Url: String?
    var video720Url: String?

    var bubblesCount: Int?
    var commentsCount: Int?
    var viewsCount: Int?
    
    var lastBubbledAt: NSDate?
    var lastCommentedAt: NSDate?
    var lastSubmittedAt: NSDate?
    
    var approved: Bool?
    var approvalStatus: String?
    var shortUrl: String?
    var createdAtAge: String?
    var createdAtAgePerCreator: [String:String] = [:]

    var userRelationship: RelationshipMapper?
    var creatorRelationships: Array<RelationshipMapper>?
    
    var reflectionText: String?
    var reflectionVideoUrl: String?
    
    var objFileUrl: String?
    var playIFrameUrl: String?

    required init?(_ map: Map) { /* Intentionally left empty  */ }
    
    func mapping(map: Map)
    {
        identifier  <- map["id"]
        name <- map["attributes.name"]
        createdAt <- (map["attributes.created_at"], APIClientDateTransform.sharedTransform)
        updatedAt <- (map["attributes.updated_at"], APIClientDateTransform.sharedTransform)
        
        imageStatus <- map["attributes.image_status"]
        
        imageOriginalUrl <- map["attributes.image.links.original"]
        imageFullViewUrl <- map["attributes.image.links.full_view"]
        imageListViewUrl <- map["attributes.image.links.list_view_retina"]
        imageListViewRetinaUrl <- map["attributes.image.links.list_view_retina"]
        imageMatrixViewUrl <- map["attributes.image.links.matrix_view"]
        imageMatrixViewRetinaUrl <- map["attributes.image.links.matrix_view_retina"]
        imageGalleryMobileUrl <- map["attributes.image.links.gallery_mobile"]
        imageExploreMobileUrl <- map["attributes.image.links.explore_mobile"]
        imageShareUrl <- map["attributes.image.links.share"]
        
        video480Url <- map["attributes.video_480_url"]
        video720Url <- map["attributes.video_720_url"]
        
        bubblesCount <- map["attributes.bubbles_count"]
        commentsCount <- map["attributes.comments_count"]
        viewsCount <- map["attributes.views_count"]
        
        lastBubbledAt <- (map["attributes.last_bubbled_at"], APIClientDateTransform.sharedTransform)
        lastCommentedAt <- (map["attributes.last_commented_at"], APIClientDateTransform.sharedTransform)
        lastSubmittedAt <- (map["attributes.last_submitted_at"], APIClientDateTransform.sharedTransform)
        
        approved <- map["attributes.approved"]
        approvalStatus <- map["attributes.approval_status"]
        shortUrl <- map["attributes.short_url"]
        createdAtAge <- map["attributes.created_at_age"]
        createdAtAgePerCreator <- map["attributes.created_at_age_per_creator"]

        userRelationship <- map["relationships.user.data"]
        creatorRelationships <- map["relationships.creators.data"]
        
        reflectionText <- map["attributes.reflection_text"]
        reflectionVideoUrl <- map["attributes.reflection_video_url"]
        
        objFileUrl <- map["attributes.obj_file_url"]
        playIFrameUrl <- map["attributes.play_iframe_url"]
    }
    
    //MARK: Parsing
    func parseCreatorRelationships() -> Array<Relationship>?
    {
        if let relationships = creatorRelationships
        {
            return relationships.map({ Relationship(mapper: $0 )})
        }
        return nil
    }

    func parseUserRelationship() -> Relationship?
    {
        return MappingUtils.relationshipFromMapper(userRelationship)        
    }
    
    func parseApprovalStatus() -> ApprovalStatus
    {
        guard let approvalStatus = approvalStatus
        else { return .Unknown }
        
        switch approvalStatus
        {
            case "approved": return .Approved
            case "unapproved": return .Unapproved
            case "rejected" :return .Rejected
            default: return .Unknown
        }
    }

}
