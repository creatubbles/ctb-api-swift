//
//  EditProfileRequest.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2017 Creatubbles Pte. Ltd.
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

class EditProfileRequest: Request {
    override var method: RequestMethod { return .put }
    override var endpoint: String { return "users/\(identifier)/account" }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }

    fileprivate let identifier: String
    fileprivate let data: EditProfileData
    init(identifier: String, data: EditProfileData) {
        self.identifier = identifier
        self.data = data
    }

    fileprivate func prepareParameters() -> Dictionary<String, AnyObject> {
        var dataDict = Dictionary<String, AnyObject>()
        var attributesDict = Dictionary<String, AnyObject>()
        var relationshipsDict = Dictionary<String, AnyObject>()

        if let value = data.username { attributesDict["username"] = value as AnyObject? }
        if let value = data.displayName { attributesDict["display_name"] = value as AnyObject? }
        if let value = data.name { attributesDict["name"] = value as AnyObject? }
        if let value = data.email { attributesDict["email"] = value as AnyObject? }
        if let value = data.birthYear { attributesDict["birth_year"] = value as AnyObject? }
        if let value = data.birthMonth { attributesDict["birth_month"] = value as AnyObject? }

        if let value = data.ageDisplayType { attributesDict["age_display_type"] = value as AnyObject? }
        if let value = data.gender { attributesDict["gender"] = value as AnyObject? }
        if let value = data.uiLocale { attributesDict["ui_locale"] = value as AnyObject? }
        if let value = data.whatDoYouTeach { attributesDict["what_do_you_teach"] = value as AnyObject? }
        if let value = data.interests { attributesDict["interests"] = value as AnyObject? }
        if let value = data.countryCode { attributesDict["country_code"] = value as AnyObject? }
        if let value = data.receiveNotifications { attributesDict["receive_notifications"] = value as AnyObject? }
        if let value = data.receiveNewswletter { attributesDict["newsletter"] = value as AnyObject? }
        if let value = data.preApproveComments { attributesDict["preapprove_comments"] = value as AnyObject? }

        if let value = data.avatarCreationIdentifier { relationshipsDict["avatar_creation"] = ["data": ["id": value]] as AnyObject? }

        dataDict["attributes"] = attributesDict as AnyObject?
        dataDict["relationships"] = relationshipsDict as AnyObject?

        return ["data": dataDict as AnyObject]
    }
}
