//
//  CreationEditRequestSpec.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 08.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//


import Quick
import Nimble
@testable import CreatubblesAPIClient

class CreationEditRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("CreationEditRequestSpec")
        {
            it("Should use PUT method")
            {
                let request = CreationEditRequest()
                except(request.method).to(equal(RequestMethod.PUT))
            }
        }
    }
}
