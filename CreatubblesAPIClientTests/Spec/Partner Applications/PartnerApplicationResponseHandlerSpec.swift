//
//  PartnerApplicationsResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 04.08.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class PartnerApplicationsResponseHandlerSpec: QuickSpec
{
    //MARK: - Tests disabled until Partner applications are ready on the api side
    
//    let id = "example-app"
//
//    override func spec()
//    {
//        describe("Partner Applications response handler")
//        {
//            it("Should return correct value after login")
//            {
//                let sender = TestComponentsFactory.requestSender
//                waitUntil(timeout: 10)
//                {
//                    done in
//                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
//                    {
//                        (error: ErrorType?) -> Void in
//                        expect(error).to(beNil())
//                        sender.send(PartnerApplicationRequest(id: self.id), withResponseHandler: PartnerApplicationResponseHandler()
//                        {
//                            (partnerApplication: PartnerApplication?, error: ErrorType?) -> Void in
//                            expect(error).to(beNil())
//                            expect(partnerApplication).notTo(beNil())
//                            done()
//                        })
//                    }
//                }
//            }
//            
//            it("Should return error when not logged in")
//            {
//                let sender = TestComponentsFactory.requestSender
//                sender.logout()
//                waitUntil(timeout: 10)
//                {
//                    done in
//                    sender.send(PartnerApplicationRequest(id: self.id), withResponseHandler:PartnerApplicationResponseHandler()
//                    {
//                        (partnerApplication: PartnerApplication?, error: ErrorType?) -> Void in
//                        expect(error).notTo(beNil())
//                        expect(partnerApplication).to(beNil())
//                        done()
//                    })
//                }
//            }
//        }
//    }
}