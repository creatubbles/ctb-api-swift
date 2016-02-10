//
//  CreatubblesAPIClient.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 05.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

public class CreatubblesAPIClient: NSObject
{
    let settings: CreatubblesAPIClientSettings        
    
    public init(settings: CreatubblesAPIClientSettings)
    {
        self.settings = settings
    }
}
