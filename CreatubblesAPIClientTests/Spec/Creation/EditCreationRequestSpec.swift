//
//  EditCreationRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 08.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//


import Quick
import Nimble
@testable import CreatubblesAPIClient

class EditCreationRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("EditCreationRequest")
        {
            it("Should use PUT method")
            {
                let request = EditCreationRequest(identifier: "", data: EditCreationData())
                expect(request.method).to(equal(RequestMethod.put))
            }
            
            it("Should use 'creations/IDENTIFIER endpoint")
            {
                let identifier = "TestIdentifier"
                let request = EditCreationRequest(identifier: identifier, data: EditCreationData())
                expect(request.endpoint).to(equal("creations/\(identifier)"))
            }
            
            it("Should return proper parameters")
            {
            
            }
        }
    }
}
