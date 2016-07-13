//
//  CreateMultipleCreatorsRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 13.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class CreateMultipleCreatorsRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("New creator request")
        {
            let amount = 15
            let birthYear = 2000
            let group = "test"

            var multipleCreatorsRequest: CreateMultipleCreatorsRequest
            {
                return CreateMultipleCreatorsRequest(amount: amount, birthYear: birthYear, group: group)
            }
            
            it("Should have proper endpoint")
            {
                let request = multipleCreatorsRequest
                expect(request.endpoint).to(equal("creator_builder_jobs"))
            }
            
            it("Should have proper method")
            {
                let request = multipleCreatorsRequest
                expect(request.method).to(equal(RequestMethod.POST))
            }
            
            it("Should have proper parameters")
            {
                let request = multipleCreatorsRequest
                let params = request.parameters
                
                expect(params["amount"] as? Int).to(equal(amount))
                expect(params["birth_year"] as? Int).to(equal(birthYear))
                expect(params["group"] as! Group).to(equal(group))
            }
            
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
                        sender.send(multipleCreatorsRequest, withResponseHandler: DummyResponseHandler()
                        {
                            (response, error) -> Void in
                            expect(response).notTo(beNil())
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
