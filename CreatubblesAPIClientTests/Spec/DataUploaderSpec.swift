//
//  DataUploaderSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 16.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import Quick
import Nimble
import Realm

@testable import CreatubblesAPIClient

class DataUploaderSpec: QuickSpec
{
    override func spec()
    {        
        describe("Creation upload session")
        {
            it("Should upload")
            {
                let path = NSBundle(forClass: self.dynamicType).URLForResource("creatubbles_logo", withExtension: "jpg")
                let image = UIImage(contentsOfFile: path!.path!)!
                let requestSender = RequestSender(settings: TestConfiguration.settings)
                let session = CreationUploadSession(data: NewCreationData(image: image), requestSender: requestSender)
                
                waitUntil(timeout: 200)
                {
                    done in
                    requestSender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        session.start
                        {
                            (creation: Creation? ,error: ErrorType?) -> Void in
                            expect(creation).notTo(beNil())
                            expect(error).to(beNil())
                            done()
                        }
                    }
                }
            }

            it("Should upload database sessions")
            {
                let databaseDAO = DatabaseDAO()
                let requestSender = RequestSender(settings: TestConfiguration.settings)
                
                let creationUploadSessions = databaseDAO.fetchAllCreationUploadSessions(requestSender)
                
                waitUntil(timeout: 200)
                {
                    done in
                    if(creationUploadSessions.count == 0)
                    {
                        done()
                        return
                    }
                        
                    requestSender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: ErrorType?) -> Void in
                        for session in creationUploadSessions
                        {
                            session.start
                            {
                                (creation: Creation? ,error: ErrorType?) -> Void in
                                expect(creation).notTo(beNil())
                                expect(error).to(beNil())
                                done()
                            }
                        }
                    }
                }
            }
        }
        
        describe("Api Client new creation")
        {
            it("Should upload new creation")
            {
                let path = NSBundle(forClass: self.dynamicType).URLForResource("creatubbles_logo", withExtension: "jpg")
                let image = UIImage(contentsOfFile: path!.path!)!
                let apiClient = CreatubblesAPIClient(settings: TestConfiguration.settings)
                
                waitUntil(timeout: 200)
                {
                    done in
                    apiClient.newCreation(NewCreationData(image: image), completion: { (creation, error) -> (Void) in
                        expect(creation).notTo(beNil())
                        expect(error).to(beNil())
                        done()
                    })
                }
            }
                
        }

    }
}