//
//  RequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 08.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import Quick
import Nimble
@testable import CreatubblesAPIClient

class RequestSpec: QuickSpec
{
    override func spec()
    {
        describe("Token request")
        {
            it("Should have proper endpoint")
            {
                let request = TokenRequest(clientId: "", clientSecret: "")
                expect(request.endpoint).to(equal("oauth/token"))
            }
            
            it("Should have proper method")
            {
                let request = TokenRequest(clientId: "", clientSecret: "")
                expect(request.method).to(equal(RequestMethod.POST))
            }
            
            it("Should provide proper parameters")
            {
                let clientId = "TestClientId"
                let clientSecret = "TestClientSecret"
                let request = TokenRequest(clientId: clientId, clientSecret: clientSecret)
                let parameters = request.parameters
                expect(parameters["client_id"] as? String).to(equal(clientId))
                expect(parameters["client_secret"] as? String).to(equal(clientSecret))
            }
            
            it("Should return correct value")
            {
                let settings = CreatubblesAPIClientSettings(appId: TestConfiguration.appId, appSecret: TestConfiguration.appSecret)
                let sender = RequestSender(settings: settings)
                
            }
        }
    }
}
