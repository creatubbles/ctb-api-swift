//
//  OAuth2KeychainClient.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 09.03.2017.
//  Copyright © 2017 Nomtek. All rights reserved.
//

import UIKit
import KeychainAccess

public class OAuth2KeychainClient: NSObject, OAuth2Client
{
    private let keychain = Keychain(service: "com.creatubbles.access-token")
    
    public var privateAccessToken: String?
    {
        get
        {
            return keychain["access-token"]
        }
        
        set
        {
            keychain["access-token"] = newValue
        }
    }
    
    public var publicAccessToken: String?
    {
        get
        {
            return keychain["public-access-token"]
        }
        set
        {
            keychain["public-access-token"] = newValue
        }
    }
    
    public func logout()
    {
        privateAccessToken = nil
    }     
}
