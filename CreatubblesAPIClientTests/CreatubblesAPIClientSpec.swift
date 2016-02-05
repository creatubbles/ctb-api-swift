//
//  CreatubblesAPIClientSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 05.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import Quick
import Nimble
@testable import CreatubblesAPIClient

class CreatubblesAPIClientSpec: QuickSpec
{
    override func spec()
    {
        describe("ApiClient Settings")
        {
            it("Have proper fields set")
            {
                let testAppId = "TestAppId"
                let testAppSecret = "TestAppSecret"
                let settings = CreatubblesAPIClientSettings(appId: testAppId, appSecret: testAppSecret)
                
                expect(settings.appId).to(equal(testAppId))
                expect(settings.appSecret).to(equal(testAppSecret))
            }
        }
    }
}
