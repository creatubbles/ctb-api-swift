//
//  DeleteGroupRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 14.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class DeleteGroupRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("Delete Group Request")
        {
            it("Should have proper method")
            {
                let request = DeleteGroupRequest(identifier: "")
                expect(request.method).to(equal(RequestMethod.DELETE))
            }
            
            it("Should have proper endpoint")
            {
                let identifier = "GroupIdentifier"
                let request = DeleteGroupRequest(identifier: identifier)
                expect(request.endpoint).to(equal("groups/\(identifier)"))
            }
            
            it("Should have no parameters set")
            {
                let request = DeleteGroupRequest(identifier: "")
                expect(request.parameters).to(beEmpty())
            }
        }
    }
}