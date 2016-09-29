//
//  PartnerApplicationsMapper.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 02.08.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
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
    var galleryRelationship: RelationshipMapper?
    var gallery: Gallery?
    var relatedAppsRelationships: Array<RelationshipMapper>?
    var relatedApps: Array<PartnerApplication>?
        
    //Mark: TODO: implement when api is ready
    //let appScreenshots: Array<AppScreenshot>
    
    //MARK: - Mappable
    required init?(_ map: Map) { /* Intentionally left empty  */ }
    
    func mapping(_ map: Map)
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
        
        galleryRelationship <- map["relationships.gallery.data"]
        relatedAppsRelationships <- map["relationships.related_apps.data"]
        
        //Mark: TODO: implement when api is ready
        //appScreenshots <- map["relationships.app_screenshots"]
    }
    
    func parseGalleryRelationship() -> Relationship?
    {
        return MappingUtils.relationshipFromMapper(galleryRelationship)
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
}
