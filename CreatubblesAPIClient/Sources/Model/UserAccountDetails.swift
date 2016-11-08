//
//  UserAccountDetails.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 21.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
open class UserAccountDetails: NSObject
{
    open let identifier: String
    open let username: String
    open let displayName: String
    open let email: String
    open let role: Role
    open let birthYear: Int?
    open let birthMonth: Int?
    open let ageDisplayType: String
    open let gender: Gender
    open let uiLocale: String?
    open let pendingAvatarUrl: String?
    open let groupList: Array<String>?
    open let ownedGroups: Array<String>?
    open let preapproveComments: Bool
    open let whatDoYouTeach: String?
    open let interests: String?
    open let managedCreatorsCount: Int
    open let countryCode: String?
    open let receiveNotifications: Bool
    open let receiveNewsletter: Bool
    open let passwordUpdatedAt: Date?
    open let currentSignInAt: Date?
    open let createdAt: Date
    open let updatedAt: Date
    
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
        passwordUpdatedAt = mapper.passwordUpdatedAt as Date?
        currentSignInAt = mapper.currentSignInAt as Date?
        createdAt = mapper.createdAt! as Date
        updatedAt = mapper.updatedAt! as Date
    }
}
