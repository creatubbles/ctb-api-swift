//
//  LandingURLRequest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 07.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

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
