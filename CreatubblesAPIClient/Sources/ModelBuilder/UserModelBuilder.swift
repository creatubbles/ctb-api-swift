//
//  UserModelBuilder.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 09.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class UserModelBuilder: NSObject, Mappable
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
        identifier  <- map["data.id"]
        username  <- map["data.attributes.username"]
        displayName  <- map["data.attributes.display_name"]
        name <- map["data.attributes.name"]
        role <- map["data.attributes.role"]
        lastBubbledAt <- (map["data.attributes.last_bubbled_at"], DateTransform())
        lastCommentedAt <- (map["data.attributes.last_commented_at"], DateTransform())
        createdAt <- (map["data.attributes.created_at"], DateTransform())
        updatedAt <- (map["data.attributes.updated_at"], DateTransform())
        avatarUrl <- map["data.attributes.avatar_url"]
        countryCode <- map["data.attributes.country_code"]
        countryName <- map["data.attributes.country_name"]
        age <- map["data.attributes.age"]
        birthYear <- map["data.attributes.birth_year"]
        birthMonth <- map["data.attributes.birth_month"]
        groups <- map["data.attributes.groups"]
        
        shortUrl <- map["data.attributes.short_url"]
        bubbledByUserIds <- map["data.attributes.bubbled_by_user_ids"]
        ownedTags <- map["data.attributes.owned_tags"]
        
        addedBubblesCount <- map["data.attributes.added_bubbles_count"]
        activitiesCount <- map["data.attributes.activities_count"]
        commentsCount <- map["data.attributes.comments_count"]
        creationsCount <- map["data.attributes.creations_count"]

        galleriesCount <- map["data.attributes.galleries_count"]
        creatorsCount <- map["data.attributes.creators_count"]
        managersCount <- map["data.attributes.managers_count"]
        
        homeSchooling <- map["data.attributes.home_schooling"]
        signedUpAsInstructor <- map["data.attributes.signed_up_as_instructor"]
        isPartner <- map["data.attributes.is_partner"]
        loggable <- map["data.attributes.loggable"]
        gspSeen <- map["data.attributes.gsp_seen"]
        uepUnwanted <- map["data.attributes.uep_unwanted"]
        isMale <- map["data.attributes.is_male"]
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
