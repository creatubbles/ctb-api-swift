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
    override var method: RequestMethod   { return .GET }
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
    
    private let type: LandingURLType?
    private let creationId: String?
    
    init(type: LandingURLType?)
    {
        assert(type != .Creation, "Please use init(creationId: String), to obtain LandingURL for creation.")
        self.type = type
        self.creationId = nil;
    }
    
    init(creationId: String)
    {
        self.type = .Creation
        self.creationId = creationId
    }
    
    private class func typeStringFromType(type: LandingURLType?) -> String?
    {
        if let type = type
        {
            switch type
            {
                case .AboutUs:        return "ctb-about_us"
                case .TermsOfUse:     return "ctb-terms_of_use"
                case .PrivacyPolicy:  return "ctb-privacy_policy"
                case .Registration:   return "ctb-registration"
                case .UserProfile:    return "ctb-user_profile"
                case .Explore:        return "ctb-explore"
                case .ForgotPassword: return "ctb-forgot_password"
                case .Creation:       return nil
            }
        }
        return nil
    }
}
