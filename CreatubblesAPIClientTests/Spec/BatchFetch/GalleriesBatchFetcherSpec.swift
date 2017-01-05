//
//  GalleriesBatchFetcherSpec.swift
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

class GalleriesBatchFetcherSpec: QuickSpec
{
    override func spec()
    {
        describe("GalleriesBatchFetcher")
        {
            it("Should batch fetch galleries using operation client")
            {
                guard TestConfiguration.shoulTestBatchFetchers else { return }

                let sender = TestComponentsFactory.requestSender
                var batchFetcher: GalleriesQueueBatchFetcher!
                waitUntil(timeout: 200)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password, completion:
                    {
                        (error) -> (Void) in
                        expect(error).to(beNil())
                        expect(sender.isLoggedIn()).to(beTrue())
                        
                        batchFetcher = GalleriesQueueBatchFetcher(requestSender: sender, userId: nil, query: nil, sort: nil)
                        {
                            (galleries, error) -> (Void) in
                            expect(galleries).notTo(beNil())
                            expect(galleries).notTo(beEmpty())
                            expect(error).to(beNil())
                            done()
                        }
                        batchFetcher.fetch()
                    })
                }
            }
            
            it("Should batch fetch favorite galleries using operation client")
            {
                guard TestConfiguration.shoulTestBatchFetchers else { return }

                let sender = TestComponentsFactory.requestSender
                var batchFetcher: FavoriteGalleriesQueueBatchFetcher!
                waitUntil(timeout: 200)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password, completion:
                    {
                        (error) -> (Void) in
                        expect(error).to(beNil())
                        expect(sender.isLoggedIn()).to(beTrue())
                        
                        batchFetcher = FavoriteGalleriesQueueBatchFetcher(requestSender: sender)
                        {
                            (galleries, error) -> (Void) in
                            expect(galleries).notTo(beNil())
                            expect(galleries).notTo(beEmpty())
                            expect(error).to(beNil())
                            done()
                        }
                        batchFetcher.fetch()
                    })
                }
            }
            
            it("Should batch fetch featured galleries using operation client")
            {
                guard TestConfiguration.shoulTestBatchFetchers else { return }
                
                let sender = TestComponentsFactory.requestSender
                var batchFetcher: FeaturedGalleriesQueueBatchFetcher!
                waitUntil(timeout: 200)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password, completion:
                    {
                        (error) -> (Void) in
                        expect(error).to(beNil())
                        expect(sender.isLoggedIn()).to(beTrue())
                        
                        batchFetcher = FeaturedGalleriesQueueBatchFetcher(requestSender: sender)
                        {
                            (galleries, error) -> (Void) in
                            expect(galleries).notTo(beNil())
                            expect(galleries).notTo(beEmpty())
                            expect(error).to(beNil())
                            done()
                        }
                        batchFetcher.fetch()
                    })
                }
            }
            
            it("Should batch fetch currently logged in user's galleries using operation client")
            {
                guard TestConfiguration.shoulTestBatchFetchers else { return }
                
                let sender = TestComponentsFactory.requestSender
                var batchFetcher: MyGalleriesQueueBatchFetcher!
                waitUntil(timeout: 200)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password, completion:
                    {
                        (error) -> (Void) in
                        expect(error).to(beNil())
                        expect(sender.isLoggedIn()).to(beTrue())
                        
                        batchFetcher = MyGalleriesQueueBatchFetcher(requestSender: sender, filter: .none)
                        {
                            (galleries, error) -> (Void) in
                            expect(galleries).notTo(beNil())
                            expect(galleries).notTo(beEmpty())
                            expect(error).to(beNil())
                            done()
                        }
                        batchFetcher.fetch()
                    })
                }
            }
        }
    }
}
