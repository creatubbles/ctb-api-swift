//
//  PartnerApplicationsSearchResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 04.08.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class PartnerApplicationsSearchResponseHandlerSpec: QuickSpec
{
    let query = "example-app"
    
    override func spec()
    {
        describe("Partner Applications Search response handler")
        {
            it("Should return correct value after login")
            {
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        expect(error).to(beNil())
                        sender.send(PartnerApplicationsSearchRequest(query: self.query), withResponseHandler: PartnerApplicationsSearchResponseHandler()
                        {
                            (partnerApplications: Array<PartnerApplication>?, error: ErrorType?) -> Void in
                            expect(error).to(beNil())
                            expect(partnerApplications).notTo(beNil())
                            done()
                        })
                    }
                }
            }
            
            it("Should return error when not logged in")
            {
                let sender = TestComponentsFactory.requestSender
                sender.logout()
                waitUntil(timeout: 10)
                {
                    done in
                    sender.send(PartnerApplicationsSearchRequest(query: self.query), withResponseHandler:PartnerApplicationsSearchResponseHandler()
                    {
                        (partnerApplications: Array<PartnerApplication>?, error: ErrorType?) -> Void in
                        expect(error).notTo(beNil())
                        expect(partnerApplications).to(beNil())
                        done()
                    })
                }
            }
        }
    }
}
