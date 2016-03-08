//
//  LandingURL.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 07.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
public class LandingURL: NSObject
{
    public let destination: String
    public let type: LandingURLType
    
 
    init(mapper: LandingURLMapper)
    {
        self.destination = mapper.destination!
        self.type = mapper.type
    }
    
    init(destination: String, type: LandingURLType)
    {
        self.destination = destination
        self.type = type
    }
}
