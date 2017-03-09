//
//  PartnerApplications.swift
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
    open let ownerCountry: String?
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
    open let userRelationship: Relationship
    open let user: User?
    open let galleryRelationship: Relationship
    open let gallery: Gallery?
    open let galleriesRelationships: Array<Relationship>?
    open let galleries: Array<Gallery>?
    open let appScreenshotsRelationships: Array<Relationship>?
    open let appScreenshots: Array<AppScreenshot>?
    
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
        ownerCountry = mapper.ownerCountry
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
        
        userRelationship = mapper.parseUserRelationship()!
        user = MappingUtils.objectFromMapper(dataMapper, relationship: userRelationship, type: User.self)
        
        galleryRelationship = mapper.parseGalleryRelationship()!
        gallery = MappingUtils.objectFromMapper(dataMapper, relationship: galleryRelationship, type: Gallery.self)
        
        galleriesRelationships = mapper.parseGalleriesRelationships()
        galleries = galleriesRelationships?.flatMap({ MappingUtils.objectFromMapper(dataMapper, relationship: $0, type: Gallery.self) })
        
        appScreenshotsRelationships = mapper.parseAppScreenshotsRelationships()
        appScreenshots = appScreenshotsRelationships?.flatMap({ MappingUtils.objectFromMapper(dataMapper, relationship: $0, type: AppScreenshot.self) })
    }
}
