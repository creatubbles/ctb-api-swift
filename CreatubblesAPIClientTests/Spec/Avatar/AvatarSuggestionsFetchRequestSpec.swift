//
//  AvatarSuggestionsRequest.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 10.11.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import Quick
import Nimble
@testable import CreatubblesAPIClient

class AvatarSuggestionsFetchRequestSpec: QuickSpec
{
    override func spec()
    {
        describe("AvatarSuggestions request")
        {
            it("Should have a proper endpoint")
            {
                let request = AvatarSuggestionsFetchRequest()
                expect(request.endpoint).to(equal("avatar_suggestions"))
            }
            
            it("Should have a proper method")
            {
                let request = AvatarSuggestionsFetchRequest()
                expect(request.method).to(equal(RequestMethod.get))
            }
        }
    }
}
