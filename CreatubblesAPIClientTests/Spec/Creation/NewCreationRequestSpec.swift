//
//  NewCreationRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class NewCreationRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("New creation request")
        {
            it("Should have proper endpoint")
            {
                let request = NewCreationRequest()
                expect(request.endpoint).to(equal("creations"))
            }
            
            it("Should have proper method")
            {
                let request = NewCreationRequest()
                expect(request.method).to(equal(RequestMethod.post))
            }
            
            it("Should have proper parameters set")
            {
                let data = NewCreationData(image: UIImage(), uploadExtension: .jpeg)
                data.name = "TestCreationName"
                data.creatorIds = ["TestCreationId1", "TestCreationId2"]
                data.creationMonth = 1
                data.creationYear = 2016
                data.reflectionText = "TestReflectionText"
                data.reflectionVideoUrl = "https://www.youtube.com/watch?v=L6B_4yMvOiQ"
                
                let request = NewCreationRequest(creationData: data)
                let params = request.parameters
                
                expect(params["name"] as? String).to(equal(data.name))
                expect(params["creator_ids"] as? String).to(equal(data.creatorIds?.joined(separator: ",")))
                expect(params["created_at_year"] as? Int).to(equal(data.creationYear))
                expect(params["created_at_month"] as? Int).to(equal(data.creationMonth))
                expect(params["reflection_text"] as? String).to(equal(data.reflectionText))
                expect(params["reflection_video_url"] as? String).to(equal(data.reflectionVideoUrl))
            }
            
            it("Should return correct value after login")
            {
                let sender = TestComponentsFactory.requestSender
                waitUntil(timeout: 10)
                {
                    done in
                    sender.login(TestConfiguration.username, password: TestConfiguration.password)
                    {
                        (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(NewCreationRequest(), withResponseHandler: DummyResponseHandler()
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
