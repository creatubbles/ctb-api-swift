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
    override var method: RequestMethod   { return .PUT }
    override var endpoint: String        { return "users/\(identifier)/account" }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    
    private let identifier: String
    private let data: EditProfileData
    init(identifier: String, data: EditProfileData)
    {
        self.identifier = identifier
        self.data = data
    }

    
    private func prepareParameters() -> Dictionary<String, AnyObject>
    {
        var dataDict = Dictionary<String, AnyObject>()
        var attributesDict = Dictionary<String, AnyObject>()
        var relationshipsDict = Dictionary<String, AnyObject>()
      
        if let value = data.username { attributesDict["username"] = value }
        if let value = data.displayName { attributesDict["display_name"] = value }
        if let value = data.name { attributesDict["name"] = value }
        if let value = data.email { attributesDict["email"] = value }
        if let value = data.birthYear  { attributesDict["birth_year"] = value }
        if let value = data.birthMonth { attributesDict["birth_month"] = value }
        
        if let value = data.ageDisplayType { attributesDict["age_display_type"] = value }
        if let value = data.gender { attributesDict["gender"] = value }
        if let value = data.uiLocale { attributesDict["ui_locale"] = value }
        if let value = data.whatDoYouTeach {attributesDict["what_do_you_teach"] = value }
        if let value = data.interests {attributesDict["interests"] = value }
        if let value = data.countryCode {attributesDict["country_code"] = value }
        if let value = data.receiveNotifications {attributesDict["receive_notifications"] = value }
        if let value = data.receiveNewswletter {attributesDict["newsletter"] = value }
        if let value = data.preApproveComments {attributesDict["preapprove_comments"] = value }
        
        if let value = data.avatarCreationIdentifier   { relationshipsDict["avatar_creation"] = ["data" : ["id" : value]] }
        
        dataDict["attributes"] = attributesDict
        dataDict["relationships"] = relationshipsDict
        
        return ["data" : dataDict]
    }
}
