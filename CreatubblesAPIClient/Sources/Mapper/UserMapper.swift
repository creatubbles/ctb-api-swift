//
//  UserMapper.swift
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

import UIKit
import ObjectMapper

class UserMapper: Mappable
{
    var identifier: String?
    var username: String?
    var displayName: String?
    var name: String?
    var role: String?
    var lastBubbledAt: NSDate?
    var lastCommentedAt: NSDate?
    var createdAt: NSDate?
    var updatedAt: NSDate?
    var avatarUrl: String?
    var countryCode: String?
    var countryName: String?
    var age: String?
    var groups: Array<GroupMapper>?
    var shortUrl: String?
    var ownedTags: Array<String>?
    
    var addedBubblesCount: Int?
    var activitiesCount: Int?
    var commentsCount: Int?
    var creationsCount: Int?
    var creatorsCount: Int?
    var galleriesCount: Int?
    var managersCount: Int?
    
    var homeSchooling: Bool?
    var signedUpAsInstructor: Bool?
    var loggable: Bool?
    var uepUnwanted: Bool?
    var isMale: Bool?
    
    //MARK: - Mappable
    required init?(_ map: Map)
    {
        
    }
    
    func mapping(map: Map)
    {
        identifier  <- map["id"]
        username  <- map["attributes.username"]
        displayName  <- map["attributes.display_name"]
        name <- map["attributes.name"]
        role <- map["attributes.role"]
        lastBubbledAt <- (map["attributes.last_bubbled_at"], DateTransform())
        lastCommentedAt <- (map["attributes.last_commented_at"], DateTransform())
        createdAt <- (map["attributes.created_at"], DateTransform())
        updatedAt <- (map["attributes.updated_at"], DateTransform())
        avatarUrl <- map["attributes.avatar_url"]
        countryCode <- map["attributes.country_code"]
        countryName <- map["attributes.country_name"]
        age <- map["attributes.age"]
        groups <- map["attributes.groups"]
        
        shortUrl <- map["attributes.short_url"]
        ownedTags <- map["attributes.owned_tags"]
        
        addedBubblesCount <- map["attributes.added_bubbles_count"]
        activitiesCount <- map["attributes.activities_count"]
        commentsCount <- map["attributes.comments_count"]
        creationsCount <- map["attributes.creations_count"]

        galleriesCount <- map["attributes.galleries_count"]
        creatorsCount <- map["attributes.creators_count"]
        managersCount <- map["attributes.managers_count"]
        
        homeSchooling <- map["attributes.home_schooling"]
        signedUpAsInstructor <- map["attributes.signed_up_as_instructor"]
        loggable <- map["attributes.loggable"]
        uepUnwanted <- map["attributes.uep_unwanted"]
        isMale <- map["attributes.is_male"]
    }
    
    //MARK: - Parsing
    func parseRole() -> Role
    {
        switch self.role!
        {
            case "parent":  return Role.Parent
            case "teacher": return Role.Teacher
            case "creator": return Role.Creator
            default:        return Role.Creator
        }
    }
    
    func parseGender() -> Gender
    {
        return isMale! ? .Male : .Female
    }
    
    func parseGroups() -> Array<Group>
    {
        var groups = Array<Group>()
        for mapper in self.groups!
        {
            groups.append(Group(mapper: mapper))
        }
        return groups
    }
}
