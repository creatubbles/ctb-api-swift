//
//  UserAccountDetails.swift
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
    
    public init(mapper: UserAccountDetailsMapper)
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
