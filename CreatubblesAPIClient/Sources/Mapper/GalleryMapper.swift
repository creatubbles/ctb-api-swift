//
//  GalleryMapper.swift
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
import UIKit
import ObjectMapper

class GalleryMapper: Mappable {
    var identifier: String?
    var name: String?
    var galleryDescription: String?
    var openForAll: Bool?
    var createdAt: Date?
    var updatedAt: Date?
    var lastBubbledAt: Date?
    var lastCommentedAt: Date?
    var creationsCount: Int?
    var bubblesCount: Int?
    var commentsCount: Int?
    var shortUrl: String?
    var previewImageUrls: Array<String>?
    var ownerRelationship: RelationshipMapper?

    var bannerOriginalUrl: String?
    var bannerListViewUrl: String?
    var bannerListViewRetinaUrl: String?
    var bannerMatrixViewUrl: String?
    var bannerMatrixViewRetinaUrl: String?
    var bannerExploreMobileUrl: String?

    var challengePublishedAt: Date?
    var galleryInstructionRelationships: Array<RelationshipMapper>?
    var connectedPartnersRelashionships: Array<RelationshipMapper>?
    
    required init?(map: Map) { /* Intentionally left empty  */ }

    func mapping(map: Map) {
        identifier <- map["id"]
        name <- map["attributes.name"]
        galleryDescription <- map["attributes.description"]
        openForAll <- map["attributes.open_for_all"]
        createdAt <- (map["attributes.created_at"], APIClientDateTransform.sharedTransform)
        updatedAt <- (map["attributes.updated_at"], APIClientDateTransform.sharedTransform)
        lastBubbledAt <- (map["attributes.last_bubbled_at"], APIClientDateTransform.sharedTransform)
        lastCommentedAt <- (map["attributes.last_commented_at"], APIClientDateTransform.sharedTransform)
        commentsCount <- map["attributes.comments_count"]
        creationsCount <- map["attributes.creations_count"]
        bubblesCount <- map["attributes.bubbles_count"]
        shortUrl <- map["attributes.short_url"]
        previewImageUrls <- map["attributes.preview_image_urls"]
        ownerRelationship <- map["relationships.owner.data"]

        bannerOriginalUrl <- map["attributes.banner.links.original"]
        bannerListViewUrl <- map["attributes.banner.links.list_view"]
        bannerListViewRetinaUrl <- map["attributes.banner.links.list_view_retina"]
        bannerMatrixViewUrl <- map["banner.links.matrix_view"]
        bannerMatrixViewRetinaUrl <- map["banner.links.matrix_view_retina"]
        bannerExploreMobileUrl <- map["banner.links.explore_mobile"]

        challengePublishedAt <- (map["attributes.challenge_published_at"], APIClientDateTransform.sharedTransform)
        galleryInstructionRelationships <- map["relationships.gallery_howto_sections.data"]
        connectedPartnersRelashionships <- map["relationships.connected_partner_applications.data"]
    }

    // MARK: Parsing
    func parseOwnerRelationship() -> Relationship? {
        return MappingUtils.relationshipFromMapper(ownerRelationship)
    }
    
    func parseGalleryInstructionRelationships() -> Array<Relationship>? {
        return galleryInstructionRelationships?.flatMap { MappingUtils.relationshipFromMapper($0) }
    }
    
    func parseConnectedPartnersRelashionships() -> Array<Relationship>? {
        return connectedPartnersRelashionships?.flatMap { MappingUtils.relationshipFromMapper($0) }
    }
}
