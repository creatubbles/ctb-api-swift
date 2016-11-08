//
//  NotificationReadResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 07.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class NotificationReadResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("NotificationReadResponseHandler")
        {
            it("Should return error when not logged in")
            {
                let request = NotificationReadRequest(notificationIdentifier: "384580")
                let sender = RequestSender(settings: TestConfiguration.settings)
                sender.logout()
                
                waitUntil(timeout: 10)
                {
                    done in
                    sender.send(request, withResponseHandler:NotificationReadResponseHandler()
                    {
                        (error) -> (Void) in
                        expect(error).to(beNil())
                        done()
                    })
                }
            }
            
            it("Should not return error when logged in")
            {
                let request = NotificationReadRequest(notificationIdentifier: "384580")
                let sender = RequestSender(settings: TestConfiguration.settings)
                
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:NotificationReadResponseHandler()
                        {
                            (error) -> (Void) in
                            expect(error).to(beNil())
                            done()
                        })
                    }
                }
            }
        }
    }
}
