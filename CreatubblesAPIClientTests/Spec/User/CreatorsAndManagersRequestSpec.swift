//
//  CreatorsAndManagersRequestSpec.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2016 Creatubbles Pte. Ltd.
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

class CreatorsAndManagersRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("Creators and Managers request")
        {
            it("Should have proper endpoint")
            {
                let request = CreatorsAndManagersRequest()
                expect(request.endpoint).to(equal("users"))
            }
            
            it("Should have proper method")
            {
                let request = CreatorsAndManagersRequest()
                expect(request.method).to(equal(RequestMethod.get))
            }
            
            it("Should have proper parameters set")
            {
                let userId = "TestUserId"
                let page = 1
                let pageCount = 10
                let scope = CreatorsAndManagersScopeElement.Creators
                
                let request = CreatorsAndManagersRequest(userId: userId, page: page, perPage: pageCount, scope: scope)
                let params = request.parameters
                expect(params["page"] as? Int).to(equal(page))
                expect(params["per_page"] as? Int).to(equal(pageCount))
                expect(params["user_id"] as? String).to(equal(userId))
                expect(params["scope"] as? String).to(equal(scope.rawValue))
            }
            
            it("Should return correct value after login")
            {
                let sender = RequestSender(settings: TestConfiguration.settings)
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(CreatorsAndManagersRequest(userId:nil, page: nil, perPage: nil, scope:.Managers), withResponseHandler: DummyResponseHandler()
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
