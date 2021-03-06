//
//  User.swift
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

@objc public enum Role: Int {
    case parent
    case instructor
    case creator

    public var stringValue: String {
        switch self {
            case .parent:   return "parent"
            case .instructor:  return "instructor"
            case .creator:  return "creator"
        }
    }
}

@objc
open class User: NSObject, Identifiable {
    open let identifier: String
    open let username: String
    open let displayName: String
    open let listName: String
    open let name: String
    open let role: Role
    open let lastBubbledAt: Date?
    open let lastCommentedAt: Date?
    open let createdAt: Date
    open let updatedAt: Date
    open let avatarUrl: String
    open let countryCode: String
    open let countryName: String
    open let age: String?
    open let gender: Gender
    open let shortUrl: String

    open let bubblesCount: Int
    open let bubblesOnCreationsCount: Int
    open let addedBubblesCount: Int
    open let activitiesCount: Int
    open let commentsCount: Int
    open let creationsCount: Int
    open let creatorsCount: Int
    open let galleriesCount: Int
    open let managersCount: Int

    open let homeSchooling: Bool
    open let signedUpAsInstructor: Bool
    open let whatDoYouTeach: String?
    open let interests: String?
    open let interestsList: Array<String>?

    // MARK: - Metadata
    open let isBubbled: Bool
    open let abilities: Array<Ability>

    open let customStyleRelationship: Relationship?
    open let customStyle: CustomStyle?

    open let isFollowed: Bool
    open let followersCount: Int
    open let followedUsersCount: Int
    open let followedHashtagsCount: Int
    open let followedGlobalCount: Int

    init(mapper: UserMapper, dataMapper: DataIncludeMapper?, metadata: Metadata? = nil) {
        identifier = mapper.identifier!
        username = mapper.username!
        displayName = mapper.displayName!
        listName = mapper.listName ?? ""
        name = mapper.name ?? ""
        role = mapper.parseRole()
        lastBubbledAt = mapper.lastBubbledAt as Date?
        lastCommentedAt = mapper.lastCommentedAt as Date?
        createdAt = mapper.createdAt ?? Date()
        updatedAt = mapper.updatedAt ?? Date()
        avatarUrl = mapper.avatarUrl!
        countryCode = mapper.countryCode != nil ? mapper.countryCode! : "US"
        countryName = mapper.countryName ?? ""
        age = mapper.age
        gender = mapper.parseGender()
        shortUrl = mapper.shortUrl ?? ""

        bubblesCount = mapper.bubblesCount ?? 0
        bubblesOnCreationsCount = mapper.bubblesOnCreationsCount ?? 0
        addedBubblesCount = mapper.addedBubblesCount ?? 0
        activitiesCount = mapper.activitiesCount ?? 0
        commentsCount = mapper.commentsCount ?? 0
        creationsCount = mapper.creationsCount ?? 0
        creatorsCount = mapper.creatorsCount ?? 0
        galleriesCount = mapper.galleriesCount ?? 0
        managersCount = mapper.managersCount ?? 0

        homeSchooling = mapper.homeSchooling ?? false
        signedUpAsInstructor = mapper.signedUpAsInstructor ?? false

        isBubbled = MappingUtils.bubbledStateFrom(metadata: metadata, forObjectWithIdentifier: identifier)
        abilities = MappingUtils.abilitiesFrom(metadata: metadata, forObjectWithIdentifier: identifier)

        isFollowed = metadata?.userFollowedUsersIdentifiers.contains(mapper.identifier!) ?? false

        customStyleRelationship = MappingUtils.relationshipFromMapper(mapper.customStyleRelationship)
        customStyle = MappingUtils.objectFromMapper(dataMapper, relationship: customStyleRelationship, type: CustomStyle.self)

        whatDoYouTeach = mapper.whatDoYouTeach
        interests = mapper.interests
        interestsList = mapper.interestsList
        
        followersCount = mapper.followersCount ?? 0
        followedUsersCount = mapper.followedUsersCount ?? 0
        followedHashtagsCount = mapper.followedHashtagsCount ?? 0
        followedGlobalCount = followedUsersCount + followedHashtagsCount
    }
}
