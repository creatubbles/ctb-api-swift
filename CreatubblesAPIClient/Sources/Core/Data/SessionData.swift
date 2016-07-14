//
//  SessionData.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 30.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc public class SessionData: NSObject {
    public var accessToken: String?
    let idToken: String?
    let accessTokenExpiry: NSDate?
    let refreshToken: String?
    
    init(accessToken: String?, idToken: String?, accessTokenExpiry: NSDate?, refreshToken: String?) {
        self.accessToken = accessToken
        self.idToken = idToken
        self.accessTokenExpiry = accessTokenExpiry
        self.refreshToken = refreshToken
    }
}
