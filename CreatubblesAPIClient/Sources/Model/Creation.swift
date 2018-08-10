//
//  Creation.swift
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
open class Creation: NSObject, Identifiable {
    open let identifier: String
    open let name: String
    open let translatedNames: Array<NameTranslationObject>
    open let createdAt: Date
    open let updatedAt: Date

    open let imageStatus: Int

    open let imageOriginalUrl: String?
    open let imageFullViewUrl: String?
    open let imageListViewUrl: String?
    open let imageListViewRetinaUrl: String?
    open let imageMatrixViewUrl: String?
    open let imageMatrixViewRetinaUrl: String?
    open let imageGalleryMobileUrl: String?
    open let imageExploreMobileUrl: String?
    open let imageShareUrl: String?

    open let video480Url: String?
    open let video720Url: String?

    open let bubblesCount: Int
    open let commentsCount: Int
    open let viewsCount: Int

    open let lastBubbledAt: Date?
    open let lastCommentedAt: Date?
    open let lastSubmittedAt: Date?

    open let approvalStatus: ApprovalStatus
    open let approved: Bool
    open let shortUrl: String
    open let createdAtAge: String?
    open let createdAtAgePerCreator: [String:String]

    open let reflectionText: String?
    open let reflectionVideoUrl: String?

    open let objFileUrl: String?
    open let playIFrameUrl: String?
    open let playIFrameUrlIsMobileReady: Bool

    open let contentType: String
    open let tags: Array<String>?

    // MARK: - Relationships
    open let owner: User?
    open let creators: Array<User>?

    open let userRelationship: Relationship?
    open let creatorRelationships: Array<Relationship>?

    // MARK: - Metadata
    open let isBubbled: Bool
    open let isFavorite: Bool
    open let abilities: Array<Ability>

    init(mapper: CreationMapper, dataMapper: DataIncludeMapper? = nil, metadata: Metadata? = nil) {
        identifier = mapper.identifier!
        name = mapper.name ?? "Untitled"

        if let translatedNamesMappers = mapper.translatedNamesMap {
            translatedNames = translatedNamesMappers.flatMap({ $0.isValid() ? NameTranslationObject(mapper: $0) : nil })
        } else {
            translatedNames = []
        }

        createdAt = mapper.createdAt! as Date
        updatedAt = mapper.updatedAt ?? mapper.createdAt!
        imageStatus = mapper.imageStatus ?? 0
        bubblesCount = mapper.bubblesCount ?? 0
        commentsCount = mapper.commentsCount ?? 0
        viewsCount = mapper.viewsCount ?? 0
        lastBubbledAt = mapper.lastBubbledAt as Date?
        lastCommentedAt = mapper.lastCommentedAt as Date?
        lastSubmittedAt = mapper.lastSubmittedAt as Date?
        approved = mapper.approved ?? true
        shortUrl = mapper.shortUrl ?? ""
        createdAtAge = mapper.createdAtAge
        createdAtAgePerCreator = mapper.createdAtAgePerCreator

        reflectionText = mapper.reflectionText
        reflectionVideoUrl = mapper.reflectionVideoUrl

        imageOriginalUrl = mapper.imageOriginalUrl
        imageFullViewUrl = mapper.imageFullViewUrl
        imageListViewUrl = mapper.imageListViewUrl
        imageListViewRetinaUrl = mapper.imageListViewRetinaUrl
        imageMatrixViewUrl = mapper.imageMatrixViewUrl
        imageMatrixViewRetinaUrl = mapper.imageMatrixViewRetinaUrl
        imageGalleryMobileUrl = mapper.imageGalleryMobileUrl
        imageExploreMobileUrl = mapper.imageExploreMobileUrl
        imageShareUrl = mapper.imageShareUrl

        video480Url = mapper.video480Url
        video720Url = mapper.video720Url

        approvalStatus = mapper.parseApprovalStatus()
        userRelationship = mapper.parseUserRelationship()
        creatorRelationships = mapper.parseCreatorRelationships()

        objFileUrl = mapper.objFileUrl
        playIFrameUrl = mapper.playIFrameUrl
        playIFrameUrlIsMobileReady = mapper.playIFrameUrlIsMobileReady ?? false

        contentType = mapper.contentType ?? ""
        tags = mapper.tags

        owner = MappingUtils.objectFromMapper(dataMapper, relationship: userRelationship, type: User.self)

        isBubbled = MappingUtils.bubbledStateFrom(metadata: metadata, forObjectWithIdentifier: identifier)
        abilities = MappingUtils.abilitiesFrom(metadata: metadata, forObjectWithIdentifier: identifier)
        isFavorite = metadata?.favoritedCreationIdentifiers.contains(identifier) ?? false
        
        if  let dataMapper = dataMapper,
            let relationships = creatorRelationships {
            creators = relationships.flatMap({ dataMapper.objectWithIdentifier($0.identifier, type: User.self) })
        } else {
            self.creators = nil
        }
    }

    init(creationEntity: CreationEntity) {
        identifier = creationEntity.identifier!
        name = creationEntity.name!

        translatedNames = creationEntity.translatedNameEntities.map({ NameTranslationObject(nameTranslationObjectEntity: $0) })

        createdAt = creationEntity.createdAt! as Date
        updatedAt = creationEntity.updatedAt! as Date
        imageStatus = creationEntity.imageStatus.value!
        bubblesCount = creationEntity.bubblesCount.value!
        commentsCount = creationEntity.commentsCount.value!
        viewsCount = creationEntity.viewsCount.value!
        lastBubbledAt = creationEntity.lastBubbledAt as Date?
        lastCommentedAt = creationEntity.lastCommentedAt as Date?
        lastSubmittedAt = creationEntity.lastSubmittedAt as Date?
        approved = creationEntity.approved.value!
        shortUrl = creationEntity.shortUrl!
        createdAtAge = creationEntity.createdAtAge

        var createdAtAgePerCreatorTemp = [String: String]()
        creationEntity.createdAtAgePerCreatorDict?.forEach({ createdAtAgePerCreatorTemp[$0.key!] = $0.value })
        createdAtAgePerCreator = createdAtAgePerCreatorTemp

        reflectionText = creationEntity.reflectionText
        reflectionVideoUrl = creationEntity.reflectionVideoUrl

        imageOriginalUrl = creationEntity.imageOriginalUrl
        imageFullViewUrl = creationEntity.imageFullViewUrl
        imageListViewUrl = creationEntity.imageListViewUrl
        imageListViewRetinaUrl = creationEntity.imageListViewRetinaUrl
        imageMatrixViewUrl = creationEntity.imageMatrixViewUrl
        imageMatrixViewRetinaUrl = creationEntity.imageMatrixViewRetinaUrl
        imageGalleryMobileUrl = creationEntity.imageGalleryMobileUrl
        imageExploreMobileUrl = creationEntity.imageExploreMobileUrl
        imageShareUrl = creationEntity.imageShareUrl

        video480Url = creationEntity.video480Url
        video720Url = creationEntity.video720Url

        objFileUrl = creationEntity.objFileUrl
        playIFrameUrl = creationEntity.playIFrameUrl
        playIFrameUrlIsMobileReady = creationEntity.playIFrameUrlIsMobileReady.value ?? false

        contentType = creationEntity.contentType ?? ""

        let entityTags: Array<String> = creationEntity.tags.flatMap { $0.tag }
        tags = entityTags.isEmpty ? nil : entityTags

        //TODO: Do we need relationships here?
        owner = nil
        creators = nil
        userRelationship = nil
        creatorRelationships = nil
        isBubbled = false
        isFavorite = false
        abilities = []
        approvalStatus = .unknown
    }
}
