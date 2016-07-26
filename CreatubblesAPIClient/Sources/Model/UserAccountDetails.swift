//
//  UserAccountDetails.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 21.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
public class UserAccountDetails: NSObject
{
    public let identifier: String
    public let username: String
    public let displayName: String
    public let email: String
    public let role: Role
    public let birthYear: Int?
    public let birthMonth: Int?
    public let ageDisplayType: String
    public let gender: Gender
    public let uiLocale: String?
    public let pendingAvatarUrl: String?
    public let groupList: Array<String>?
    public let ownedGroups: Array<String>?
    public let preapproveComments: Bool
    public let whatDoYouTeach: String?
    public let interests: String?
    public let managedCreatorsCount: Int
    public let countryCode: String?
    public let receiveNotifications: Bool
    public let receiveNewsletter: Bool
    public let passwordUpdatedAt: NSDate?
    public let currentSignInAt: NSDate?
    public let createdAt: NSDate
    public let updatedAt: NSDate
    
    init(mapper: UserAccountDetailsMapper)
    {
        identifier = mapper.identifier!
        username  = mapper.username!
        displayName = mapper.displayName!
        email = mapper.email!
        role = mapper.role
        
        birthYear = mapper.birthYear
        birthMonth = mapper.birthMonth
        ageDisplayType = mapper.ageDisplayType!
        gender = mapper.gender
        uiLocale = mapper.uiLocale
        pendingAvatarUrl = mapper.pendingAvatarUrl
        groupList = mapper.groupList ?? []
        ownedGroups = mapper.ownedGroups ?? []
        preapproveComments = mapper.preapproveComments!
        whatDoYouTeach = mapper.whatDoYouTeach
        interests = mapper.interests
        managedCreatorsCount = mapper.managedCreatorsCount!
        countryCode = mapper.countryCode
        receiveNotifications = mapper.receiveNotifications!
        receiveNewsletter = mapper.receiveNewsletter!
        passwordUpdatedAt = mapper.passwordUpdatedAt
        currentSignInAt = mapper.currentSignInAt
        createdAt = mapper.createdAt!
        updatedAt = mapper.updatedAt!
    }
}