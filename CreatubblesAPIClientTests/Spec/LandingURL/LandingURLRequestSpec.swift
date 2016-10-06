//
//  LandingURLRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class LandingURLRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("LandingURL request")
        {
            it("Should have proper method")
            {
                let request = LandingURLRequest(type: nil)
                expect(request.method).to(equal(RequestMethod.get))
            }
            
            it("Should have proper endpoint for LandingURLType")
            {
                expect(LandingURLRequest(type: nil).endpoint).to(equal("landing_urls"))
                expect(LandingURLRequest(type: .aboutUs).endpoint).to(equal("landing_urls/ctb-about_us"))
                expect(LandingURLRequest(type: .termsOfUse).endpoint).to(equal("landing_urls/ctb-terms_of_use"))
                expect(LandingURLRequest(type: .privacyPolicy).endpoint).to(equal("landing_urls/ctb-privacy_policy"))
                expect(LandingURLRequest(type: .registration).endpoint).to(equal("landing_urls/ctb-registration"))
                expect(LandingURLRequest(type: .userProfile).endpoint).to(equal("landing_urls/ctb-user_profile"))
                expect(LandingURLRequest(type: .explore).endpoint).to(equal("landing_urls/ctb-explore"))
                expect(LandingURLRequest(type: .forgotPassword).endpoint).to(equal("landing_urls/ctb-forgot_password"))
                expect(LandingURLRequest(type: .uploadGuidelines).endpoint).to(equal("landing_urls/cte-upload_guidelines"))
                expect(LandingURLRequest(type: .accountDashboard).endpoint).to(equal("landing_urls/cte-account_dashboard"))
            }
            
            it("Should have proper endpoint for Creation LandingURL")
            {
                let creationId = "MyCreationId"
                let request = LandingURLRequest(creationId: creationId)
                expect(request.endpoint).to(equal("creations/\(creationId)/landing_url"))
            }
        }
    }
}

