//
//  LandingURLMapper.swift
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

import UIKit
import ObjectMapper



class LandingURLMapper: Mappable
{
    var destination: String?
    fileprivate var typeString: String?
    
    required init?(map: Map) { /* Intentionally left empty  */ }
    
    func mapping(map: Map)
    {
        destination <- map["attributes.url"]
        typeString <- map["id"]
    }
    
    var type: LandingURLType
    {
        if typeString == "ctb-about_us"          { return LandingURLType.aboutUs }
        if typeString == "ctb-terms_of_use"      { return LandingURLType.termsOfUse }
        if typeString == "ctb-privacy_policy"    { return LandingURLType.privacyPolicy }
        if typeString == "ctb-user_profile"      { return LandingURLType.userProfile }
        if typeString == "ctb-registration"      { return LandingURLType.registration }
        if typeString == "ctb-explore"           { return LandingURLType.explore }
        if typeString == "ctb-forgot_password"   { return LandingURLType.forgotPassword }
        if typeString == "cte-account_dashboard" { return LandingURLType.accountDashboard }
        if typeString == "cte-upload_guidelines" { return LandingURLType.uploadGuidelines }
        
        Logger.log.warning("Unknown landingURL: \(self.typeString)")
        return .unknown
    }
}
