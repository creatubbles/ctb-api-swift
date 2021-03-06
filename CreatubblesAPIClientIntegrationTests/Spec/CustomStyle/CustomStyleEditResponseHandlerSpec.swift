//
//  CustomStyleEditResponseHandlerSpec.swift
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

class CustomStyleEditResponseHandlerSpec: QuickSpec {
    override func spec() {
        describe("CustomStyleEditResponseHandlerSpec") {
            it("Should handle response for changing CustomStyle of user") {
                guard let identifier = TestConfiguration.testUserIdentifier
                else { return }

                let data = CustomStyleEditData()

                data.headerBackgroundIndex = 3
                data.headerColors = [UIColor.red]
                data.bodyBackgroundIndex = 1
                data.bodyColors = [UIColor.blue]

                let request = CustomStyleEditRequest(userIdentifier: identifier, data: data)

                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: TestConfiguration.timeoutMedium) {
                    done in
                    _ = sender.login(TestConfiguration.username, password: TestConfiguration.password) {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        _ = sender.send(request, withResponseHandler:CustomStyleEditResponseHandler {
                            (customStyle, error) -> (Void) in
                            expect(customStyle).notTo(beNil())
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
