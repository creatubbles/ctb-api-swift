//
//  RemoveCreationRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 11.10.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class RemoveCreationRequestSpec: QuickSpec
{
    override func spec()
    {
        
        describe("Remove Creation Request")
        {
            it("Should have a proper endpoint")
            {
                let creationId = "creationId"
                let request = RemoveCreationRequest(creationId: creationId)
                
                expect(request.endpoint).to(equal("creations/\(creationId)"))
            }
        }
        it("Should use DELETE method")
        {
            let request = RemoveCreationRequest(creationId: "")
            expect(request.method).to(equal(RequestMethod.delete))
        }
    }
}
