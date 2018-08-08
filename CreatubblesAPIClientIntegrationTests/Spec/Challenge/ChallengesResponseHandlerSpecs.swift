//
//  ChallengesResponseHandlerSpecs.swift
//  CreatubblesAPIClientIntegrationTests
//
//  Copyright (c) 2017 Creatubbles Pte. Ltd.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class ChallengesResponseHandlerSpecs: QuickSpec {
    override func spec() {
        describe("Challenges response handler") {
            it("Should return home challenges after login") {
                let request = ChallengesRequest(group: .home, page: 1, perPage: 20)
                let sender = TestComponentsFactory.requestSender
                
                waitUntil(timeout: TestConfiguration.timeoutShort) {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:ChallengesResponseHandler {
                            (challenges, error) -> (Void) in
                            expect(error).to(beNil())
                            expect(challenges).notTo(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
            
            it("Should return favorite challenges after login") {
                let request = ChallengesRequest(group: .favorite, page: 1, perPage: 20)
                let sender = TestComponentsFactory.requestSender
                
                waitUntil(timeout: TestConfiguration.timeoutShort) {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:ChallengesResponseHandler {
                            (challenges, error) -> (Void) in
                            expect(error).to(beNil())
                            expect(challenges).notTo(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
            
            it("Should return challenge details after login") {
                let request = ChallengeRequest(id: "1vIikLL2")
                let sender = TestComponentsFactory.requestSender
                
                waitUntil(timeout: TestConfiguration.timeoutShort) {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:ChallengeResponseHandler {
                            (challenge, error) -> (Void) in
                            expect(error).to(beNil())
                            expect(challenge).notTo(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
        }
    }
}
