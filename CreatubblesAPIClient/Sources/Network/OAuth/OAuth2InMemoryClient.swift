//
//  OAuth2InMemoryClient.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 09.03.2017.
//  Copyright © 2017 Nomtek. All rights reserved.
//

import UIKit

public class OAuth2InMemoryClient: NSObject, OAuth2Client
{
    public var privateAccessToken: String?
    public var publicAccessToken: String?
    
    public func logout()
    {
        privateAccessToken = nil
    }
}
