//
//  AvatarSuggestions.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 10.11.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class AvatarSuggestionsFetchRequest: Request
{
    override var method: RequestMethod  { return .get }
    override var endpoint: String
    {
        return "avatar_suggestions"
    }
}
