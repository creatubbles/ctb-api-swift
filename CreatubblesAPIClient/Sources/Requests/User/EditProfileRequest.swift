//
//  EditProfileRequest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 15.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class EditProfileRequest: Request
{
    override var method: RequestMethod   { return .put }
    override var endpoint: String        { return "users/\(identifier)/account" }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    
    fileprivate let identifier: String
    fileprivate let data: EditProfileData
    init(identifier: String, data: EditProfileData)
    {
        self.identifier = identifier
        self.data = data
    }

    
    fileprivate func prepareParameters() -> Dictionary<String, AnyObject>
    {
        var dataDict = Dictionary<String, AnyObject>()
        var attributesDict = Dictionary<String, AnyObject>()
        var relationshipsDict = Dictionary<String, AnyObject>()
      
        if let value = data.username { attributesDict["username"] = value as AnyObject? }
        if let value = data.displayName { attributesDict["display_name"] = value as AnyObject? }
        if let value = data.name { attributesDict["name"] = value as AnyObject? }
        if let value = data.email { attributesDict["email"] = value as AnyObject? }
        if let value = data.birthYear  { attributesDict["birth_year"] = value as AnyObject? }
        if let value = data.birthMonth { attributesDict["birth_month"] = value as AnyObject? }
        
        if let value = data.ageDisplayType { attributesDict["age_display_type"] = value as AnyObject? }
        if let value = data.gender { attributesDict["gender"] = value as AnyObject? }
        if let value = data.uiLocale { attributesDict["ui_locale"] = value as AnyObject? }
        if let value = data.whatDoYouTeach {attributesDict["what_do_you_teach"] = value as AnyObject? }
        if let value = data.interests {attributesDict["interests"] = value as AnyObject? }
        if let value = data.countryCode {attributesDict["country_code"] = value as AnyObject? }
        if let value = data.receiveNotifications {attributesDict["receive_notifications"] = value as AnyObject? }
        if let value = data.receiveNewswletter {attributesDict["newsletter"] = value as AnyObject? }
        if let value = data.preApproveComments {attributesDict["preapprove_comments"] = value as AnyObject? }
        
        if let value = data.avatarCreationIdentifier   { relationshipsDict["avatar_creation"] = ["data" : ["id" : value]] }
        
        dataDict["attributes"] = attributesDict as AnyObject?
        dataDict["relationships"] = relationshipsDict as AnyObject?
        
        return ["data" : dataDict as AnyObject]
    }
}
