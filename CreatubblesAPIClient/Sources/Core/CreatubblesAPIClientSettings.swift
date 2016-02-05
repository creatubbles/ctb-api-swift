//
//  CreatubblesAPIClientSettings.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 05.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

public class CreatubblesAPIClientSettings: NSObject
{
    let appId: String
    let appSecret: String
    
    init(appId: String, appSecret: String)
    {
        self.appId = appId
        self.appSecret = appSecret
    }
}
