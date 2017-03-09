//
//  LandingURLRequestSpec.swift
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

