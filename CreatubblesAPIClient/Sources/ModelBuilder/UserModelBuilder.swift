//
//  UserModelBuilder.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 09.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class UserModelBuilder: Mappable
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
    var birthYear: Int?
    var birthMonth: Int?
    var groups: Array<GroupModelBuilder>?
    var shortUrl: String?
    var bubbledByUserIds: Array<String>?
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
    var isPartner: Bool?
    var loggable: Bool?
    var gspSeen: Bool?
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
        birthYear <- map["attributes.birth_year"]
        birthMonth <- map["attributes.birth_month"]
        groups <- map["attributes.groups"]
        
        shortUrl <- map["attributes.short_url"]
        bubbledByUserIds <- map["attributes.bubbled_by_user_ids"]
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
        isPartner <- map["attributes.is_partner"]
        loggable <- map["attributes.loggable"]
        gspSeen <- map["attributes.gsp_seen"]
        uepUnwanted <- map["attributes.uep_unwanted"]
        isMale <- map["attributes.is_male"]
    }
    
    //MARK: - Parsing
    func parseRole() -> Role
    {
        return Role(rawValue: self.role!)!
    }
    
    func parseGender() -> Gender
    {
        return isMale! ? .Male : .Female
    }
    
    func parseGroups() -> Array<Group>
    {
        print(self.groups)
        return Array<Group>()
    }
}
