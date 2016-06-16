//
//  CreationPingRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class CreationPingRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("Creation ping request")
        {
            it("Should have proper method")
            {
                let request = NewCreationPingRequest(uploadId: "12345")
                expect(request.method).to(equal(RequestMethod.PUT))
            }
            
            it("Should have proper endpoint")
            {
                let uploadId = "12345"
                let request = NewCreationPingRequest(uploadId: uploadId)
                expect(request.endpoint).to(equal("uploads/"+uploadId))
            }
            
            it("Should have proper parameters")
            {
                let abortError = "AbortError"
                let successfulRequest = NewCreationPingRequest(uploadId: "12345")
                let failedRequest = NewCreationPingRequest(uploadId: "12345", abortError: abortError)
                expect(successfulRequest.parameters).to(beEmpty())
                expect(failedRequest.parameters["aborted_with"] as? String).to(equal(abortError))
            }
        }

    }
}

