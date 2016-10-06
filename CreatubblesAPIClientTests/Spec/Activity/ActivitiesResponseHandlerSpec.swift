//
//  ActivitiesResponseHandlerSpec.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 22.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class ActivitiesResponseHandlerSpec: QuickSpec {
    
    override func spec() {
        
        describe("Activities response handler") {
            
            it("Should return activities") {
                
                let request = ActivitiesRequest(page: nil, perPage: nil)
                let sender = RequestSender(settings: TestConfiguration.settings)
                
                waitUntil(timeout: 10) { done in
                    
                    sender.login(TestConfiguration.username, password: TestConfiguration.password) { (error: Error?) -> Void in
                        expect(error).to(beNil())
                        sender.send(request, withResponseHandler:ActivitiesResponseHandler() { (activities, pageInfo, error) -> (Void) in
                            expect(error).to(beNil())
                            expect(activities).notTo(beNil())
                            expect(pageInfo).notTo(beNil())
                            sender.logout()
                            done()
                        })
                    }
                }
            }
        }
    }
}
