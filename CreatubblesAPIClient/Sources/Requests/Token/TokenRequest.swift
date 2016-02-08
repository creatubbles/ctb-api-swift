//
//  TokenRequest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 05.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class TokenRequest: Request
{
    override var endpoint: String { return "oauth/token" }
    override var method: RequestMethod { return .POST }
    override var parameters: Dictionary<String, AnyObject>
    {
        return [
            "grant_type":"client_credentials",
            "client_id": clientId,
            "client_secret": clientSecret
        ]
    }
    
    private let clientId: String
    private let clientSecret: String
    
    init(clientId: String, clientSecret: String)
    {
        self.clientId = clientId
        self.clientSecret = clientSecret
    }
}
