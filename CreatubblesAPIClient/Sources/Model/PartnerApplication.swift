//
//  PartnerApplications.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 02.08.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//
import UIKit

@objc
open class PartnerApplication: NSObject, Identifiable
{
    open let identifier: String
    open let name: String
    open let slug: String
    open let shorturl: String
    
    open let headerBgLinksOriginal: String?
    open let headerBgLinksListViewRetina: String?
    open let headerBgLinksListview: String?
    open let headerBgLinksMagrixViewRetina: String?
    open let headerBgLinksMatrixView: String?
    open let headerBgLinksExploreMobile: String?
    
    open let bodyBgLinksOriginal: String?
    open let bodyBgLinksListViewRetina: String?
    open let bodyBgLinksListView: String?
    open let bodyBgLinksMatrixViewRetina: String?
    open let bodyBgLinksMatrixView: String?
    open let bodyBgLinksExploreMobile: String?
    
    open let ownerName: String?
    open let partnerDescription: String?
    
    open let ctaLoggedInLabel: String?
    open let ctaLoggedOutLabel: String?
    open let requestCtaForYoungsters: Bool
    open let ctaForYoungsters: String?
    open let ctaHref: String?
    
    open let categories: String?
    open let age: String?
    open let languages: String?
    open let support: String?
    open let developers: String?
    open let platforms: String?
    open let showOtherApps: Bool
    open let displayCreationsNr: Int?
    open let aboutCardText: String?
    
    open let metaTitle: String?
    open let metaDescription: String?
    open let metaKeywords: String?
    open let metaOgTitle: String?
    open let metaOgDescription: String?
    open let metaOgType: String?
    open let metaOgImage: String?
    
    open let avatarUrl: String?
    open let createdAt: Date
    open let updatedAt: Date
    
    //MARK: Relationships
    open let galleryRelationship: Relationship
    open let gallery: Gallery
    open let relatedAppsRelationships: Array<Relationship>?
    open let relatedApps: Array<PartnerApplication>?
    
    //Mark: TODO: implement when api is ready
    //public let appScreenshots: Array<AppScreenshot>
    
    init(mapper: PartnerApplicationsMapper, dataMapper: DataIncludeMapper? = nil, metadata: Metadata? = nil)
    {
        identifier = mapper.identifier!
        name = mapper.name!
        slug = mapper.slug!
        shorturl = mapper.shorturl!
        
        headerBgLinksOriginal = mapper.headerBgLinksOriginal
        headerBgLinksListViewRetina = mapper.headerBgLinksListViewRetina
        headerBgLinksListview = mapper.headerBgLinksListview
        headerBgLinksMagrixViewRetina = mapper.headerBgLinksMagrixViewRetina
        headerBgLinksMatrixView = mapper.headerBgLinksMatrixView
        headerBgLinksExploreMobile = mapper.headerBgLinksExploreMobile
        
        bodyBgLinksOriginal = mapper.bodyBgLinksOriginal
        bodyBgLinksListViewRetina = mapper.bodyBgLinksListViewRetina
        bodyBgLinksListView = mapper.bodyBgLinksListView
        bodyBgLinksMatrixViewRetina = mapper.bodyBgLinksMatrixViewRetina
        bodyBgLinksMatrixView = mapper.bodyBgLinksMatrixView
        bodyBgLinksExploreMobile = mapper.bodyBgLinksExploreMobile

        ownerName = mapper.ownerName
        partnerDescription = mapper.partnerDescription
        
        ctaLoggedInLabel = mapper.ctaLoggedInLabel
        ctaLoggedOutLabel = mapper.ctaLoggedOutLabel
        requestCtaForYoungsters = mapper.requestCtaForYoungsters!
        ctaForYoungsters = mapper.ctaForYoungsters
        ctaHref = mapper.ctaHref
        
        categories = mapper.categories
        age = mapper.age
        languages = mapper.languages
        support = mapper.support
        developers = mapper.developers
        platforms = mapper.platforms
        showOtherApps = mapper.showOtherApps!
        displayCreationsNr = mapper.displayCreationsNr
        aboutCardText = mapper.aboutCardText
        
        metaTitle = mapper.metaTitle
        metaDescription = mapper.metaDescription
        metaKeywords = mapper.metaKeywords
        metaOgTitle = mapper.metaOgTitle
        metaOgDescription = mapper.metaOgDescription
        metaOgType = mapper.metaOgType
        metaOgImage = mapper.metaOgImage
        
        avatarUrl = mapper.avatarUrl
        createdAt = mapper.createdAt! as Date
        updatedAt = mapper.updatedAt! as Date
        
        galleryRelationship = mapper.parseGalleryRelationship()!
        gallery = MappingUtils.objectFromMapper(dataMapper, relationship: galleryRelationship, type: Gallery.self)!
        
        relatedAppsRelationships = mapper.parseRelatedAppsRelationships()
        if let relatedAppsRelationships = relatedAppsRelationships
        {
            relatedApps = Array<PartnerApplication>()
            
            for relationship in relatedAppsRelationships
            {
                relatedApps?.append(MappingUtils.objectFromMapper(dataMapper, relationship: relationship, type: PartnerApplication.self)!)
            }
        }
        else
        {
            relatedApps = nil
        }
    }
}
