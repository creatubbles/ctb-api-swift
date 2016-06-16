//
//  EditProfileData.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 15.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Foundation

@objc
public class EditProfileData: NSObject
{
    public var username: String?
    public var displayName: String?
    public var name: String?
    public var email: String?
    public var birthYear: Int?      // >1900
    public var birthMonth: Int?
    public var ageDisplayType: String?  //Change to enum
    public var gender: String?          //Change to enum
    public var uiLocale: String?        //Change to enum
    public var preApproveComments: Bool?
    public var whatDoYouTeach: String?
    public var interests: String?
    public var countryCode: String?
    public var receiveNotifications: Bool?
    public var receiveNewswletter: Bool?
    public var avatarCreationIdentifier: String?        
}
