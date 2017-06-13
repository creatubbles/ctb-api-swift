//
//  NewCreatorRequestSpec.swift
//  CreatubblesAPIClient
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

class NewCreatorRequestSpec: QuickSpec {
    override func spec() {
        describe("New creator request") {
            let name = "TestCreatorName"
            let displayName = "TestCreatorDisplayName"
            let birthYear = 2_000
            let birthMonth = 10
            let countryCode = "PL"
            let gender = Gender.male
            var creatorRequest: NewCreatorRequest {
                return NewCreatorRequest(name: name, displayName: displayName,
                                         birthYear: birthYear, birthMonth: birthMonth,
                                         countryCode: countryCode, gender: gender)
            }

            it("Should have proper endpoint") {
                let request = creatorRequest
                expect(request.endpoint) == "creators"
            }

            it("Should have proper method") {
                let request = creatorRequest
                expect(request.method) == RequestMethod.post
            }

            it("Should have proper parameters") {
                let request = creatorRequest
                let params = request.parameters
                expect(params["name"] as? String) == name
                expect(params["display_name"] as? String) == displayName
                expect(params["birth_year"] as? Int) == birthYear
                expect(params["birth_month"] as? Int) == birthMonth
                expect(params["country"] as? String) == countryCode
                expect(params["gender"] as? Int) == gender.rawValue
            }
        }
    }
}
