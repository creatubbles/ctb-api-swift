//
//  CreationsBatchFetcherSpec.swift
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

class GallerySubmitterSpec: QuickSpec
{
    override func spec()
    {
        describe("GallerySubmitter")
        {
            it("Should submit creation to gallery")
            {
                guard TestConfiguration.shoulTestBatchFetchers,
                      let galleryIdentifiers = TestConfiguration.testGalleryIdentifiers
                else { return }
                
                let sender = TestComponentsFactory.requestSender
                var submitter: GallerySubmitter!
                
                waitUntil(timeout: TestConfiguration.timeoutLong)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error) -> (Void) in
                        expect(error).to(beNil())
                        expect(sender.isLoggedIn()).to(beTrue())
                        
                        //We have to create a new unique creation - all creations in a single gallery must have unique id
                        sender.send(NewCreationRequest(creationData: NewCreationData(image: UIImage(), uploadExtension: .jpeg)), withResponseHandler:NewCreationResponseHandler()
                        {
                            (creation: Creation?, error:Error?) -> Void in
                            expect(error).to(beNil())
                            expect(creation).notTo(beNil())
                            
                            guard let identifier = creation?.identifier
                            else
                            {
                                fail("Creation's identifier should not be nil")
                                return
                            }
                            
                            submitter = GallerySubmitter(requestSender: sender, creationId: identifier, galleryIdentifiers: galleryIdentifiers)
                            {
                                (error) -> (Void) in
                                expect(error).to(beNil())
                                done()
                            }
                            submitter.submit()
                        })
                    }
                }
            }
        }
    }
}
