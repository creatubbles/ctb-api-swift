//
//  OAuth2Client.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 26.10.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import KeychainAccess

class OAuth2Client: NSObject {
    private let keychain = Keychain(service: "com.creatubbles.access-token")
    
    var accessToken: String? {
        get {
            return keychain["access-token"]
        }
        
        set {
            keychain["access-token"] = newValue
        }
    }
    
    func logout() {
        accessToken = nil
    }
}
