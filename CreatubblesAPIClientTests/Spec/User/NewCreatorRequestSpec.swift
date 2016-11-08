//
//  NewCreatorRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class NewCreatorRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("New creator request")
        {
            let timestamp = String(Int(round(NSDate().timeIntervalSince1970 .truncatingRemainder(dividingBy: 1000))))
            let name = "MMCreator"+timestamp
            let displayName = "MMCreator"+timestamp
            let birthYear = 2000
            let birthMonth = 10
            let countryCode = "PL"
            let gender = Gender.male
            var creatorRequest: NewCreatorRequest
            {
                return NewCreatorRequest(name: name, displayName: displayName,
                                         birthYear: birthYear, birthMonth: birthMonth,
                                         countryCode: countryCode, gender: gender)
            }
            
            it("Should have proper endpoint")
            {
                let request = creatorRequest
                expect(request.endpoint).to(equal("creators"))
            }
            
            it("Should have proper method")
            {
                let request = creatorRequest
                expect(request.method).to(equal(RequestMethod.post))
            }
            
            it("Should have proper parameters")
            {
                let request = creatorRequest
                let params = request.parameters
                expect(params["name"] as? String).to(equal(name))
                expect(params["display_name"] as? String).to(equal(displayName))
                expect(params["birth_year"] as? Int).to(equal(birthYear))
                expect(params["birth_month"] as? Int).to(equal(birthMonth))
                expect(params["country"] as? String).to(equal(countryCode))
                expect(params["gender"] as? Int).to(equal(gender.rawValue))
            }
            
            it("Should return correct value after login")
            {
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(creatorRequest, withResponseHandler: DummyResponseHandler()
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

