//
//  UserAccountDetailsMapper.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 21.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class UserAccountDetailsMapper: Mappable
{
    var identifier: String?
    var username: String?
    var displayName: String?
    var email: String?
    var roleString: String?
    var birthYear: Int?
    var birthMonth: Int?
    var ageDisplayType: String?
    var genderString: String?
    var uiLocale: String?
    var pendingAvatarUrl: String?
    var groupList: Array<String>?
    var ownedGroups: Array<String>?
    var preapproveComments: Bool?
    var whatDoYouTeach: String?
    var interests: String?
    var managedCreatorsCount: Int?
    var countryCode: String?
    var receiveNotifications: Bool?
    var receiveNewsletter: Bool?
    var passwordUpdatedAt: Date?
    var currentSignInAt: Date?
    var createdAt: Date?
    var updatedAt: Date?
    
    required init?(map: Map) { /* Intentionally left empty  */ }
    
    func mapping(map: Map)
    {
        identifier <- map["id"]
        username <- map["attributes.username"]
        displayName <- map["attributes.display_name"]
        email <- map["attributes.email"]
        roleString <- map["attributes.role"]
        birthYear <- map["attributes.birth_year"]
        birthMonth <- map["attributes.birth_month"]
        ageDisplayType <- map["attributes.age_display_type"]
        genderString <- map["attributes.gender"]
        uiLocale <- map["attributes.ui_locale"]
        pendingAvatarUrl <- map["attributes.pending_avatar_url"]
        groupList <- map["attributes.group_list"]
        ownedGroups <- map["attributes.owned_groups"]
        preapproveComments <- map["attributes.preapprove_comments"]
        whatDoYouTeach <- map["attributes.what_do_you_teach"]
        interests <- map["attributes.interests"]
        managedCreatorsCount <- map["attributes.managed_creators_count"]
        countryCode <- map["attributes.country_code"]
        receiveNotifications <- map["attributes.receive_notifications"]
        receiveNewsletter <- map["attributes.newsletter"]
        
        passwordUpdatedAt <- (map["attributes.password_updated_at"], APIClientDateTransform.sharedTransform)
        currentSignInAt <- (map["attributes.current_sign_in_at"], APIClientDateTransform.sharedTransform)
        createdAt <- (map["attributes.created_at"], APIClientDateTransform.sharedTransform)
        updatedAt <- (map["attributes.updated_at"], APIClientDateTransform.sharedTransform)
    }
    
    var role: Role
    {
        if roleString == "parent"     { return .parent }
        if roleString == "instructor" { return .instructor }
        if roleString == "creator"    { return .creator }
        
        Logger.log.warning("Unkown or missing role string in user account detail")
        return Role.creator
    }
    
    var gender: Gender
    {
        if genderString == "male"   { return .male }
        if genderString == "female" { return .female }
        return .unknown
    }
}
