//
//  LandingURLMapper.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 07.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class LandingURLMapper: Mappable
{
    var destination: String?
    private var typeString: String?
    
    required init?(_ map: Map)
    {
        
    }
    
    func mapping(map: Map)
    {
        destination <- map["attributes.url"]
        typeString <- map["id"]
    }
    
    var type: LandingURLType
    {
        switch self.typeString!
        {
            case "ctb-about_us": return LandingURLType.AboutUs
            case "ctb-terms_of_use": return LandingURLType.TermsOfUse
            case "ctb-privacy_policy": return LandingURLType.PrivacyPolicy
            case "ctb-user_profile": return LandingURLType.UserProfile
            case "ctb-registration": return LandingURLType.Registration
            case "ctb-explore": return LandingURLType.Explore
            
            default: return LandingURLType.Explore
        }
    }
}