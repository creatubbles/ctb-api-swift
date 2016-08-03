//
//  PartnerApplications.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 02.08.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//
import UIKit

@objc
public class PartnerApplication: NSObject
{
    public let id: String
    public let name: String
    public let slug: String
    public let shorturl: String
    
    public let headerBgLinksOriginal: String?
    public let headerBgLinksListViewRetina: String?
    public let headerBgLinksListview: String?
    public let headerBgLinksMagrixViewRetina: String?
    public let headerBgLinksMatrixView: String?
    public let headerBgLinksExploreMobile: String?
    
    public let bodyBgLinksOriginal: String?
    public let bodyBgLinksListViewRetina: String?
    public let bodyBgLinksListView: String?
    public let bodyBgLinksMatrixViewRetina: String?
    public let bodyBgLinksMatrixView: String?
    public let bodyBgLinksExploreMobile: String?
    
    public let ownerName: String?
    public let partnerDescription: String?
    
    public let ctaLoggedInLabel: String?
    public let ctaLoggedOutLabel: String?
    public let requestCtaForYoungsters: Bool
    public let ctaForYoungsters: String?
    public let ctaHref: String?
    
    public let categories: String?
    public let age: String?
    public let languages: String?
    public let support: String?
    public let developers: String?
    public let platforms: String?
    public let showOtherApps: Bool
    public let displayCreationsNr: Int?
    public let aboutCardText: String?
    
    public let metaTitle: String?
    public let metaDescription: String?
    public let metaKeywords: String?
    public let metaOgTitle: String?
    public let metaOgDescription: String?
    public let metaOgType: String?
    public let metaOgImage: String?
    
    public let avatarUrl: String?
    public let createdAt: NSDate
    public let updatedAt: NSDate
    
    //MARK: Relationships
    public let gallery: Gallery?
    public let relatedApps: Array<PartnerApplication>?
    
    //Mark: TODO: implement when api is ready
    //public let appScreenshots: Array<AppScreenshot>
    
    init(mapper: PartnerApplicationsMapper, dataMapper: DataIncludeMapper? = nil, metadata: Metadata? = nil)
    {
        id = mapper.id!
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
        createdAt = mapper.createdAt!
        updatedAt = mapper.updatedAt!
        
        gallery = mapper.gallery
        relatedApps = mapper.relatedApps
        //appScreenshots = mapper.appScreenshots
    }
}
