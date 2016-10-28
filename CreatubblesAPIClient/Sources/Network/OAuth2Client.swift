//
//  OAuth2Client.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 26.10.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class OAuth2Client: NSObject {
    var accessToken: String? {
        get {
            return UserDefaults.standard.string(forKey: "accessToken")
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: "accessToken")
            UserDefaults.standard.synchronize()
        }
    }
    
    func logout() {
        accessToken = nil
    }
}
