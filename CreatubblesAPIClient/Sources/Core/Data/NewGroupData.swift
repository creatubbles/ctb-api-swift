//
//  NewGroupData.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 14.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
class NewGroupData: NSObject
{
    let name: String
    let avatarCreationIdentifier: String?
    
    init(name: String, avatarCreationIdentifier: String? = nil)
    {
        self.name = name
        self.avatarCreationIdentifier = avatarCreationIdentifier
    }
}
