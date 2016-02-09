//
//  Group.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 09.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class Group: NSObject
{
    let identifier: String
    let name: String
    
    init(builder: GroupModelBuilder)
    {
        identifier = builder.identifier!
        name = builder.name!
    }
}
