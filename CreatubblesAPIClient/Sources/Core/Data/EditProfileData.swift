//
//  EditProfileData.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 15.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Foundation

@objc
open class EditProfileData: NSObject
{
    open var username: String?
    open var displayName: String?
    open var name: String?
    open var email: String?
    open var birthYear: Int?      // >1900
    open var birthMonth: Int?
    open var ageDisplayType: String?  //Change to enum
    open var gender: String?          //Change to enum
    open var uiLocale: String?        //Change to enum
    open var preApproveComments: Bool?
    open var whatDoYouTeach: String?
    open var interests: String?
    open var countryCode: String?
    open var receiveNotifications: Bool?
    open var receiveNewswletter: Bool?
    open var avatarCreationIdentifier: String?        
}
