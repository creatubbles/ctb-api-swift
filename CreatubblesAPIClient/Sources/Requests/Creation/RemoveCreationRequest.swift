//
//  RemoveCreationRequest.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 11.10.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class RemoveCreationRequest: Request
{
    override var method: RequestMethod  { return .delete }
    override var endpoint: String       { return "creations/\(creationId)" }
    
    private let creationId: String
    
    init(creationId: String)
    {
        self.creationId = creationId
    }
}
