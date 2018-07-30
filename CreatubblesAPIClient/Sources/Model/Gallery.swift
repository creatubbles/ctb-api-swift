//
//  Gallery.swift
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

@objc
open class Gallery: NSObject, Identifiable {
    open let identifier: String
    open let name: String
    open let createdAt: Date
    open let updatedAt: Date
    open let creationsCount: Int
    open let bubblesCount: Int
    open let commentsCount: Int
    open let shortUrl: String
    open let previewImageUrls: Array<String>

    open let lastBubbledAt: Date?
    open let lastCommentedAt: Date?
    open let galleryDescription: String?

    open let openForAll: Bool

    open let bannerOriginalUrl: String?
    open let bannerListViewUrl: String?
    open let bannerListViewRetinaUrl: String?
    open let bannerMatrixViewUrl: String?
    open let bannerMatrixViewRetinaUrl: String?
    open let bannerExploreMobileUrl: String?

    open let challengePublishedAt: Date?
    
    // MARK: - Relationships
    open let owner: User?
    open let ownerRelationship: Relationship?

    open let galleryInstructionRelationships: Array<Relationship>?
    open let galleryInstructions: Array<GalleryInstruction>?
    open let galleryConnectedPartnersRelationships: Array<Relationship>?
    open let galleryConnectedPartners: Array<PartnerApplication>?

    // MARK: - Metadata
    open let isBubbled: Bool
    open let isFavorite: Bool
    open let abilities: Array<Ability>

    init(mapper: GalleryMapper, dataMapper: DataIncludeMapper? = nil, metadata: Metadata? = nil) {
        identifier = mapper.identifier!
        name = mapper.name!
        createdAt = mapper.createdAt! as Date
        updatedAt = mapper.updatedAt! as Date
        creationsCount = mapper.creationsCount!
        bubblesCount = mapper.bubblesCount!
        commentsCount = mapper.commentsCount!
        shortUrl = mapper.shortUrl!
        previewImageUrls = mapper.previewImageUrls ?? []

        lastBubbledAt = mapper.lastBubbledAt as Date?
        lastCommentedAt = mapper.lastCommentedAt as Date?
        galleryDescription = mapper.galleryDescription

        openForAll = mapper.openForAll!

        bannerOriginalUrl = mapper.bannerOriginalUrl
        bannerListViewUrl = mapper.bannerListViewUrl
        bannerListViewRetinaUrl = mapper.bannerListViewRetinaUrl
        bannerMatrixViewUrl = mapper.bannerMatrixViewUrl
        bannerMatrixViewRetinaUrl = mapper.bannerMatrixViewRetinaUrl
        bannerExploreMobileUrl = mapper.bannerExploreMobileUrl

        challengePublishedAt = mapper.challengePublishedAt
                
        isBubbled = MappingUtils.bubbledStateFrom(metadata: metadata, forObjectWithIdentifier: identifier)
        isFavorite = metadata?.favoritedGallerydentifiers.contains(identifier) ?? false
        abilities = MappingUtils.abilitiesFrom(metadata: metadata, forObjectWithIdentifier: identifier)

        ownerRelationship = mapper.parseOwnerRelationship()
        owner = MappingUtils.objectFromMapper(dataMapper, relationship: ownerRelationship, type: User.self)
        
        galleryInstructionRelationships = mapper.parseGalleryInstructionRelationships()
        galleryInstructions = galleryInstructionRelationships?.flatMap { MappingUtils.objectFromMapper(dataMapper, relationship: $0, type: GalleryInstruction.self) }
        
        galleryConnectedPartnersRelationships = mapper.parseConnectedPartnersRelashionships()
        galleryConnectedPartners = galleryConnectedPartnersRelationships?.flatMap { MappingUtils.objectFromMapper(dataMapper, relationship: $0, type: PartnerApplication.self, shouldMap2ndLevelRelationships: false) }
    }
}
