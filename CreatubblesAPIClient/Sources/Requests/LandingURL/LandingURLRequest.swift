//
//  LandingURLRequest.swift
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

class LandingURLRequest: Request
{
    override var method: RequestMethod   { return .get }
    override var endpoint: String
    {
        if let creationId = creationId
        {
            return "creations/\(creationId)/landing_url"
        }
        if let typeStr = LandingURLRequest.typeStringFromType(type)
        {
            return "landing_urls/\(typeStr)"
        }
        return "landing_urls"
    }
    
    fileprivate let type: LandingURLType?
    fileprivate let creationId: String?
    
    init(type: LandingURLType?)
    {
        assert(type != .creation, "Please use init(creationId: String), to obtain LandingURL for creation.")
        assert(type != .unknown, "Unkown type is for read-only purposes. Please don't use it in LandingURL requests.")
        self.type = type
        self.creationId = nil;
    }
    
    init(creationId: String)
    {
        self.type = .creation
        self.creationId = creationId
    }
    
    fileprivate class func typeStringFromType(_ type: LandingURLType?) -> String?
    {
        if let type = type
        {
            switch type
            {
                case .aboutUs:        return "ctb-about_us"
                case .termsOfUse:     return "ctb-terms_of_use"
                case .privacyPolicy:  return "ctb-privacy_policy"
                case .registration:   return "ctb-registration"
                case .userProfile:    return "ctb-user_profile"
                case .explore:        return "ctb-explore"
                case .forgotPassword: return "ctb-forgot_password"
                case .accountDashboard: return "cte-account_dashboard"
                case .uploadGuidelines: return "cte-upload_guidelines"
                case .creation:        return nil
                case .unknown:         return nil
            }
        }
        return nil
    }
}
