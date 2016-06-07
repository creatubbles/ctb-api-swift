//
//  NotificationsFetchResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 07.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class NotificationsFetchResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("NotificationsFetchResponseHandler")
        {
            it("Should fetch notificaions when user is logged in")
            {
                let request = NotificationsFetchRequest()
                let sender = RequestSender(settings: TestConfiguration.settings)
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:NotificationsFetchResponseHandler()
                        {
                            (notifications, pInfo, error) -> (Void) in
                            expect(notifications).notTo(beNil())
                            expect(notifications).notTo(beEmpty())
                            expect(pInfo).notTo(beNil())
                            expect(error).to(beNil())
                            done()
                        })
                    }
                }
            }
        }
    }
}
