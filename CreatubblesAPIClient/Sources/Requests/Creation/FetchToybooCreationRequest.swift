//
//  FetchToybooCreationRequest.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 02.11.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class FetchToybooCreationRequest: Request
{
    override var method: RequestMethod   { return .GET }
    override var endpoint: String        { return "creations/\(creationId)/toyboo_details" }
    
    private let creationId: String
    
    init(creationId: String)
    {
        self.creationId = creationId
    }
}
