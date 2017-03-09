//
//  DataUploaderSpec.swift
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

import UIKit
import Quick
import Nimble
import Realm

@testable import CreatubblesAPIClient

class DataUploaderSpec: QuickSpec
{
//    override func spec()
//    {
//        describe("Creation upload session")
//        {
//            it("Should upload image and add a creation to a gallery")
//            {
//                let path = Bundle(for: type(of: self)).url(forResource:"creatubbles_logo", withExtension: "jpg")
//                let image = UIImage(contentsOfFile: path!.path)!
//                let requestSender = TestComponentsFactory.requestSender
//                let session = CreationUploadSession(data: NewCreationData(image: image, uploadExtension: .jpg), requestSender: requestSender)
//
//                waitUntil(timeout: 30)
//                {
//                    done in
//                    requestSender.login(TestConfiguration.username, password: TestConfiguration.password)
//                    {
//                        (error: Error?) -> Void in
//                        session.start
//                        {
//                            (creation: Creation? ,error: Error?) -> Void in
//                            expect(creation).notTo(beNil())
//                            expect(error).to(beNil())
//                            done()
//                        }
//                    }
//                }
//            }
//            it("Should upload video")
//            {
//                let path = Bundle(for: type(of: self)).url(forResource:"testVideo", withExtension: "mp4")
//                let requestSender = TestComponentsFactory.requestSender
//                let session = CreationUploadSession(data: NewCreationData(url: path!, uploadExtension: .mp4), requestSender: requestSender)
//                
//                waitUntil(timeout: 30)
//                {
//                    done in
//                    requestSender.login(TestConfiguration.username, password: TestConfiguration.password)
//                    {
//                        (error: Error?) -> Void in
//                        session.start
//                        {
//                            (creation: Creation? ,error: Error?) -> Void in
//                            expect(creation).notTo(beNil())
//                            expect(error).to(beNil())
//                            done()
//                        }
//                    }
//                }
//            }
//            it("Should upload zip file")
//            {
//                let path = Bundle(for: type(of: self)).url(forResource: "test", withExtension: "zip")
//                let requestSender = TestComponentsFactory.requestSender
//                guard let data = try? Data(contentsOf: path!)
//                else
//                {
//                    fail()
//                    return
//                }
//                
//                let session = CreationUploadSession(data: NewCreationData(data: data, uploadExtension: .zip), requestSender: requestSender)
//                
//                waitUntil(timeout: 30)
//                {
//                    done in
//                    requestSender.login(TestConfiguration.username, password: TestConfiguration.password)
//                    {
//                        (error: Error?) -> Void in
//                        session.start
//                        {
//                            (creation: Creation? ,error: Error?) -> Void in
//                            expect(creation).notTo(beNil())
//                            expect(error).to(beNil())
//                            done()
//                        }
//                    }
//                }
//            }
//            it("Should upload database sessions")
//            {
//                let databaseDAO = DatabaseDAO()
//                let requestSender = TestComponentsFactory.requestSender
//                
//                let creationUploadSessions = databaseDAO.fetchAllCreationUploadSessions(requestSender)
//                
//                waitUntil(timeout: 30)
//                {
//                    done in
//                    if(creationUploadSessions.count == 0)
//                    {
//                        done()
//                        return
//                    }
//                        
//                    requestSender.login(TestConfiguration.username, password: TestConfiguration.password)
//                    {
//                        (error: Error?) -> Void in
//                        for session in creationUploadSessions
//                        {
//                            session.start
//                            {
//                                (creation: Creation? ,error: Error?) -> Void in
//                                expect(creation).notTo(beNil())
//                                expect(error).to(beNil())
//                                done()
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        
//        describe("APIClient ")
//        {
//            it("Should upload new creation")
//            {
//                let path = Bundle(for: type(of: self)).url(forResource:"creatubbles_logo", withExtension: "jpg")
//                let image = UIImage(contentsOfFile: path!.path)!
//                let apiClient = APIClient(settings: TestConfiguration.settings)
//                let data = NewCreationData(image: image, uploadExtension: .jpg)
//                waitUntil(timeout: 30)
//                {
//                    done in
//                    apiClient.login(username: TestConfiguration.username, password: TestConfiguration.password, completion:
//                    {
//                        (error) -> (Void) in
//                        expect(error).to(beNil())
//                        apiClient.newCreation(data: data, completion:
//                        {
//                            (creation, error) -> (Void) in
//                            expect(creation).notTo(beNil())
//                            expect(error).to(beNil())
//                            done()
//                        })
//
//                    })
//                }
//            }
//        }
//    }
}

