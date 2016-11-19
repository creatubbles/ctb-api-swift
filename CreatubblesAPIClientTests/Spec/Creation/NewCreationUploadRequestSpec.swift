//
//  NewCreationUploadRequestSpec.swift
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

class NewCreationUploadRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("New creation upload request")
        {
            it("Should have proper method")
            {
                let request = NewCreationUploadRequest(creationId: "TestId")
                expect(request.method).to(equal(RequestMethod.post))
            }
            
            it("Should have proper endpoint")
            {
                let identifier = "TestId"
                let request = NewCreationUploadRequest(creationId: identifier)
                expect(request.endpoint).to(equal("creations/"+identifier+"/uploads"))
            }
            
            it("Should have proper params")
            {
                let defaultRequest = NewCreationUploadRequest(creationId: "TestId")
                expect(defaultRequest.parameters["extension"]).to(beNil())
                
                let availableExtensions = [UploadExtension.png, UploadExtension.jpg, UploadExtension.jpeg, UploadExtension.h264, UploadExtension.mpeg4, UploadExtension.wmv, UploadExtension.webm, UploadExtension.flv, UploadExtension.ogg, UploadExtension.ogv, UploadExtension.mp4, UploadExtension.m4V, UploadExtension.mov]
                for availableExtension in availableExtensions
                {
                    let  request = NewCreationUploadRequest(creationId: "TestId", creationExtension: availableExtension)
                    expect(request.parameters["extension"] as? String).to(equal(availableExtension.stringValue))
                }
            }
            
            it("Should return correct value after login")
            {
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 30)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(NewCreationUploadRequest(creationId: "hkwIetSk"), withResponseHandler: DummyResponseHandler()
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

