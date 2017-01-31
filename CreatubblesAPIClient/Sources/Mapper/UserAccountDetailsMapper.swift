//
//  UserAccountDetailsMapper.swift
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
//


import UIKit
import ObjectMapper

public class UserAccountDetailsMapper: Mappable
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
    
    public required init?(map: Map) { /* Intentionally left empty  */ }
    
    public func mapping(map: Map)
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
        
        Logger.log(.warning, "Unkown or missing role string in user account detail")
        return Role.creator
    }
    
    var gender: Gender
    {
        if genderString == "male"   { return .male }
        if genderString == "female" { return .female }
        return .unknown
    }
}
