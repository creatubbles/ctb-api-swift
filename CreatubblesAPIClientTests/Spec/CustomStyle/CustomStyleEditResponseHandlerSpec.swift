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
                data.headerColors = [UIColor.red]
                data.bodyBackgroundIndex = 1
                data.bodyColors = [UIColor.blue]
                
                let request = CustomStyleEditRequest(userIdentifier: identifier, data: data)
                
                let sender = RequestSender(settings: TestConfiguration.settings)
                waitUntil(timeout: 10)
                {
                    done in
                    _ = sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        _ = sender.send(request, withResponseHandler:CustomStyleEditResponseHandler()
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
