//
//  UserMapper.swift
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

class UserMapper: Mappable {
    var identifier: String?
    var username: String?
    var displayName: String?
    var listName: String?
    var name: String?
    var role: String?
    var lastBubbledAt: Date?
    var lastCommentedAt: Date?
    var createdAt: Date?
    var updatedAt: Date?
    var avatarUrl: String?
    var countryCode: String?
    var countryName: String?
    var age: String?
    var shortUrl: String?

    var bubblesCount: Int?
    var bubblesOnCreationsCount: Int?
    var addedBubblesCount: Int?
    var activitiesCount: Int?
    var commentsCount: Int?
    var creationsCount: Int?
    var creatorsCount: Int?
    var galleriesCount: Int?
    var managersCount: Int?

    var homeSchooling: Bool?
    var signedUpAsInstructor: Bool?

    var gender: String?
    var customStyleRelationship: RelationshipMapper?

    var whatDoYouTeach: String?
    var interests: String?
    var interestsList: Array<String>?
    
    var followersCount: Int?
    var followedUsersCount: Int?
    var followedHashtagsCount: Int?
    
    // MARK: - Mappable
    required init?(map: Map) { /* Intentionally left empty  */ }

    func mapping(map: Map) {
        identifier <- map["id"]
        username <- map["attributes.username"]
        displayName <- map["attributes.display_name"]
        listName <- map["attributes.list_name"]
        name <- map["attributes.name"]
        role <- map["attributes.role"]
        lastBubbledAt <- (map["attributes.last_bubbled_at"], APIClientDateTransform.sharedTransform)
        lastCommentedAt <- (map["attributes.last_commented_at"], APIClientDateTransform.sharedTransform)
        createdAt <- (map["attributes.created_at"], APIClientDateTransform.sharedTransform)
        updatedAt <- (map["attributes.updated_at"], APIClientDateTransform.sharedTransform)
        avatarUrl <- map["attributes.avatar_url"]
        countryCode <- map["attributes.country_code"]
        countryName <- map["attributes.country_name"]
        age <- map["attributes.age"]
        shortUrl <- map["attributes.short_url"]

        bubblesCount <- map["attributes.bubbles_count"]
        bubblesOnCreationsCount <- map["attributes.bubbles_on_creations_count"]
        addedBubblesCount <- map["attributes.added_bubbles_count"]
        activitiesCount <- map["attributes.activities_count"]
        commentsCount <- map["attributes.comments_count"]
        creationsCount <- map["attributes.creations_count"]

        galleriesCount <- map["attributes.galleries_count"]
        creatorsCount <- map["attributes.creators_count"]
        managersCount <- map["attributes.managers_count"]

        homeSchooling <- map["attributes.home_schooling"]
        signedUpAsInstructor <- map["attributes.signed_up_as_instructor"]
        gender <- map["attributes.gender"]

        customStyleRelationship <- map["relationships.custom_style.data"]

        whatDoYouTeach <- map["attributes.what_do_you_teach"]
        interests <- map["attributes.interests"]
        interestsList <- map["attributes.interest_list"]
        
        followersCount <- map["attributes.followers_count"]
        followedUsersCount <- map["attributes.followed_users_count"]
        followedHashtagsCount <- map["attributes.followed_hashtags_count"]
    }

    // MARK: - Parsing
    func parseRole() -> Role {
        switch self.role! {
            case "parent":  return Role.parent
            case "instructor": return Role.instructor
            case "creator": return Role.creator
            default:        return Role.creator
        }
    }

    func parseGender() -> Gender {
        if gender == "male" { return .male }
        if gender == "female" { return .female }
        return .unknown
    }
}
