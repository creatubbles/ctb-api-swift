//
//  CustomStyleEditResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 04.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class CustomStyleEditResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("CustomStyleEditResponseHandlerSpec")
        {
            it("Should handle response for changing CustomStyle of user")
            {
                guard let identifier = TestConfiguration.testUserIdentifier
                else { return }
                
                let data = CustomStyleEditData()
                
                data.headerBackgroundIndex = 3
                data.headerColors = [UIColor.redColor()]
                data.bodyBackgroundIndex = 1
                data.bodyColors = [UIColor.blueColor()]
                
                let request = CustomStyleEditRequest(userIdentifier: identifier, data: data)
                
                let sender = RequestSender(settings: TestConfiguration.settings)
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:CustomStyleEditResponseHandler()
                        {
                            (customStyle, error) -> (Void) in
                            expect(customStyle).notTo(beNil())
                            expect(error).to(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
        }
    }
}