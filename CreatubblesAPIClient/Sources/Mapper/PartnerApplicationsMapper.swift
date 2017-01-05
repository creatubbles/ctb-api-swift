//
//  PartnerApplicationsMapper.swift
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
//


import UIKit
import ObjectMapper

class PartnerApplicationsMapper: Mappable
{
    var identifier: String?
    var name: String?
    var slug: String?
    var shorturl: String?
    
    var headerBgLinksOriginal: String?
    var headerBgLinksListViewRetina: String?
    var headerBgLinksListview: String?
    var headerBgLinksMagrixViewRetina: String?
    var headerBgLinksMatrixView: String?
    var headerBgLinksExploreMobile: String?
    
    var bodyBgLinksOriginal: String?
    var bodyBgLinksListViewRetina: String?
    var bodyBgLinksListView: String?
    var bodyBgLinksMatrixViewRetina: String?
    var bodyBgLinksMatrixView: String?
    var bodyBgLinksExploreMobile: String?
    
    var ownerName: String?
    var ownerCountry: String?
    var partnerDescription: String?
    
    var ctaLoggedInLabel: String?
    var ctaLoggedOutLabel: String?
    var requestCtaForYoungsters: Bool?
    var ctaForYoungsters: String?
    var ctaHref: String?
    
    var categories: String?
    var age: String?
    var languages: String?
    var support: String?
    var developers: String?
    var platforms: String?
    var showOtherApps: Bool?
    var displayCreationsNr: Int?
    var aboutCardText: String?
    var metaTitle: String?
    var metaDescription: String?
    var metaKeywords: String?
    var metaOgTitle: String?
    var metaOgDescription: String?
    var metaOgType: String?
    var metaOgImage: String?
    var avatarUrl: String?
    var createdAt: Date?
    var updatedAt: Date?
    
    //MARK: Relationships
    var userRelationship: RelationshipMapper?
    var user: User?
    var galleryRelationship: RelationshipMapper?
    var gallery: Gallery?
    var galleriesRelationships: Array<RelationshipMapper>?
    var galleries: Array<Gallery>?
    var relatedAppsRelationships: Array<RelationshipMapper>?
    var relatedApps: Array<PartnerApplication>?
    var appScreenshotsRelationships: Array<RelationshipMapper>?
    var appScreenshots: Array<AppScreenshot>?
    
    //MARK: - Mappable
    required init?(map: Map) { /* Intentionally left empty  */ }
    
    func mapping(map: Map)
    {
        identifier <- map["id"]
        name <- map["attributes.name"]
        slug <- map["attributes.slug"]
        shorturl <- map["attributes.short_url"]
        
        headerBgLinksOriginal <- map["attributes.header_bg.links.original"]
        headerBgLinksListViewRetina <- map["attributes.header_bg.links.list_view_retina"]
        headerBgLinksListview <- map["attributes.header_bg.links.list_view"]
        headerBgLinksMagrixViewRetina <- map["attributes.header_bg.links.matrix_view_retina"]
        headerBgLinksMatrixView <- map["attributes.header_bg.links.matrix_view"]
        headerBgLinksExploreMobile <- map["attributes.header_bg.links.explore_mobile"]
        
        bodyBgLinksOriginal <- map["attributes.body_bg.links.original"]
        bodyBgLinksListViewRetina <- map["attributes.body_bg.links.list_view_retina"]
        bodyBgLinksListView <- map["attributes.body_bg.links.list_view"]
        bodyBgLinksMatrixViewRetina <- map["attributes.body_bg.links.matrix_view_retina"]
        bodyBgLinksMatrixView <- map["attributes.body_bg.links.matrix_view"]
        bodyBgLinksExploreMobile <- map["attributes.body_bg.links.explore_mobile"]
        
        ownerName <- map["attributes.owner_name"]
        ownerCountry <- map["attributes.owner_country"]
        partnerDescription <- map["attributes.description"]
        
        ctaLoggedInLabel <- map["attributes.cta_logged_in_label"]
        ctaLoggedOutLabel <- map["attributes.cta_logged_out_label"]

        requestCtaForYoungsters <- map["attributes.reqeust_cta_for_youngsters"]
        ctaForYoungsters <- map["attributes.cta_for_youngsters_label"]
        ctaHref <- map["attributes.cta_href"]
        categories <- map["attributes.categories"]
        age <- map["attributes.age"]
        languages <- map["attributes.languages"]
        support <- map["attributes.support"]
        developers <- map["attributes.developers"]
        platforms <- map["attributes.platforms"]
        showOtherApps <- map["attributes.show_other_apps"]
        displayCreationsNr <- map["attributes.display_creations_nr"]
        aboutCardText <- map["attributes.about_card_text"]
        metaTitle <- map["attributes.meta_title"]
        metaDescription <- map["attributes.meta_description"]
        metaKeywords <- map["attributes.meta_keywords"]
        metaOgTitle <- map["attributes.meta_og_title"]
        metaOgDescription <- map["attributes.meta_og_description"]
        metaOgType <- map["attributes.meta_og_type"]
        metaOgImage <- map["attributes.meta_og_image"]
        avatarUrl <- map["attributes.avatar_url"]
        createdAt <- (map["attributes.created_at"], APIClientDateTransform.sharedTransform)
        updatedAt <- (map["attributes.updated_at"], APIClientDateTransform.sharedTransform)
        
        userRelationship <- map["relationships.user.data"]
        galleryRelationship <- map["relationships.gallery.data"]
        galleriesRelationships <- map["relationships.galleries.data"]
        relatedAppsRelationships <- map["relationships.related_apps.data"]
        appScreenshotsRelationships <- map["relationships.app_screenshots.data"]
    }
    
    func parseUserRelationship() -> Relationship?
    {
        return MappingUtils.relationshipFromMapper(userRelationship)
    }
    
    func parseGalleryRelationship() -> Relationship?
    {
        return MappingUtils.relationshipFromMapper(galleryRelationship)
    }
    
    func parseGalleriesRelationships() -> Array<Relationship>?
    {
        if let galleriesRelationships = galleriesRelationships
        {
            var relationships = Array<Relationship>()
            for relationship in galleriesRelationships
            {
                relationships.append(MappingUtils.relationshipFromMapper(relationship)!)
            }
            return relationships
        }
        return nil
    }
    
    func parseRelatedAppsRelationships() -> Array<Relationship>?
    {
        if let relatedAppsRelationships = relatedAppsRelationships
        {
            var relationships = Array<Relationship>()
            for relationship in relatedAppsRelationships
            {
                relationships.append(MappingUtils.relationshipFromMapper(relationship)!)
            }
            return relationships
        }
        return nil
    }
    
    func parseAppScreenshotsRelationships() -> Array<Relationship>?
    {
        if let appScreenshotsRelationships = appScreenshotsRelationships
        {
            var relationships = Array<Relationship>()
            for relationship in appScreenshotsRelationships
            {
                relationships.append(MappingUtils.relationshipFromMapper(relationship)!)
            }
            return relationships
        }
        return nil
    }
}
