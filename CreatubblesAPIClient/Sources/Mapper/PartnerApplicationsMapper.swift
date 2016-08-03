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
    var id: String?
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
    var showOtherApps: Bool
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
    var createdAt: NSDate?
    var updatedAt: NSDate?
    
    //MARK: Relationships
    var gallery: Gallery?
    var relatedApps: Array<PartnerApplication>?
    
    //Mark: TODO: implement when api is ready
    //let appScreenshots: Array<AppScreenshot>
    
    
    required init?(_ map: Map) { /* Intentionally left empty  */ }
    
    func mapping(map: Map)
    {
        id <- map["id"]
        name <- map["name"]
        slug <- map["slug"]
        shorturl <- map["short_url"]
        
        headerBgLinksOriginal <- map["header_bg.links.original"]
        headerBgLinksListViewRetina <- map["header_bg.links.list_view_retina"]
        headerBgLinksListview <- map["header_bg.links.list_view"]
        headerBgLinksMagrixViewRetina <- map["header_bg.links.matrix_view_retina"]
        headerBgLinksMatrixView <- map["header_bg.links.matrix_view"]
        headerBgLinksExploreMobile <- map["header_bg.links.explore_mobile"]
        
        bodyBgLinksOriginal <- map["body_bg.links.original"]
        bodyBgLinksListViewRetina <- map["body_bg.links.list_view_retina"]
        bodyBgLinksListView <- map["body_bg.links.list_view"]
        bodyBgLinksMatrixViewRetina <- map["body_bg.links.matrix_view_retina"]
        bodyBgLinksMatrixView <- map["body_bg.links.matrix_view"]
        bodyBgLinksExploreMobile <- map["body_bg.links.explore_mobile"]
        
        ownerName <- map["owner_name"]
        partnerDescription <- map["description"]
        
        ctaLoggedInLabel <- map["cta_logged_in_label"]
        ctaLoggedOutLabel <- map["cta_logged_out_label"]

        requestCtaForYoungsters <- map["reqeust_cta_for_youngsters"]
        ctaForYoungsters <- map["cta_for_youngsters_label"]
        ctaHref <- map["cta_href"]
        categories <- map["categories"]
        age <- map["age"]
        languages <- map["languages"]
        support <- map["support"]
        developers <- map["developers"]
        platforms <- map["platforms"]
        showOtherApps <- map["show_other_apps"]
        displayCreationsNr <- map["display_creations_nr"]
        aboutCardText <- map["about_card_text"]
        metaTitle <- map["meta_title"]
        metaDescription <- map["meta_description"]
        metaKeywords <- map["meta_keywords"]
        metaOgTitle <- map["meta_og_title"]
        metaOgDescription <- map["meta_og_description"]
        metaOgType <- map["meta_og_type"]
        metaOgImage <- map["meta_og_image"]
        avatarUrl <- map["avatar_url"]
        createdAt <- map["created_at"]
        updatedAt <- map["updated_at"]
        
        gallery <- map["gallery"]
        relatedApps <- map["related_apps"]
        //appScreenshots <- map["app_screenshots"]
    }
}
