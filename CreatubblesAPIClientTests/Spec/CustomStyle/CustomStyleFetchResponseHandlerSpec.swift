
//
//  CustomStyleFetchResponseHandlerSpec.swift
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


import UIKit

import Quick
import Nimble
@testable import CreatubblesAPIClient


class CustomStyleFetchResponseHandlerSpec: QuickSpec
{
    override func spec()
    {
        describe("CustomStyleResponseHandler")
        {
            it("Should return custom style for user without login")
            {
                guard let identifier = TestConfiguration.testUserIdentifier
                else { return }
                
                //For now API returns error 500 for some users, valid identifier: a60rC05Y
                let request = CustomStyleFetchRequest(userIdentifier: identifier)
                let sender = TestComponentsFactory.requestSender
                
                waitUntil(timeout: 30)
                {
                    done in
                    sender.authenticate()
                    {
                        (err) -> Void in
                        expect(err).to(beNil())
                        sender.send(request, withResponseHandler: CustomStyleFetchResponseHandler()
                        {
                            (style: CustomStyle?, error: APIClientError?) -> Void in
                            expect(style).notTo(beNil())
                            expect(error).to(beNil())
                            done()
                        })
                    }
                }
            }            
        }
    }
}
