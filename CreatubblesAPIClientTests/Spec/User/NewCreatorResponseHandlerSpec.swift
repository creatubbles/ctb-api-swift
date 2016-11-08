//
//  NewCreatorResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class NewCreatorResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("New creator response handler")
        {
//            let timestamp = String(Int(round(NSDate().time)))
            let timestamp = String(Int(round(NSDate().timeIntervalSince1970.truncatingRemainder(dividingBy: 1000))))
            let name = "MMCreator"+timestamp
            let displayName = "MMCreator"+timestamp
            let birthYear = 2000
            let birthMonth = 10
            let countryCode = "PL"
            let gender = Gender.male
            var creatorRequest: NewCreatorRequest { return NewCreatorRequest(name: name, displayName: displayName, birthYear: birthYear,
                                                                             birthMonth: birthMonth, countryCode: countryCode, gender: gender) }
            
            it("Should return correct value after login")
            {
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    _ = sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        _ = sender.send(creatorRequest, withResponseHandler:NewCreatorResponseHandler()
                            {
                                (user: User?, error: Error?) -> Void in
                                expect(error).to(beNil())
                                expect(user).notTo(beNil())
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
                    _ = sender.send(creatorRequest, withResponseHandler:NewCreatorResponseHandler()
                        {
                            (user: User?, error: Error?) -> Void in
                            expect(error).notTo(beNil())
                            expect(user).to(beNil())
                            done()
                        })
                }
            }
        }
    }
}

