//
//  NotificationsViewTrackerResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 11.10.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class NotificationsViewTrackerResponseHandlerSpec: QuickSpec
{
    override func spec()
    {

        describe("Notifications View Tracker Response Handler")
        {
            it("Should return error when user is not logged in")
            {
                let request = NotificationsViewTrackerRequest()
                let sender = RequestSender(settings: TestConfiguration.settings)
                sender.logout()
                
                waitUntil(timeout: 10)
                {
                    done in
                    sender.send(request, withResponseHandler:NotificationsViewTrackerResponseHandler()
                    {
                        (error) in
                        expect(error).notTo(beNil())
                        done()
                    })
                }
            }
            
            it("Shouldn't return any errors when user is logged in")
            {
                let request = NotificationsViewTrackerRequest()
                let sender = RequestSender(settings: TestConfiguration.settings)
                
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password, completion:
                    {
                        error in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:NotificationsViewTrackerResponseHandler()
                        {
                            (error) in
                            expect(error).to(beNil())
                            done()
                        })
                    })
                }
            }
        }
    }
}
