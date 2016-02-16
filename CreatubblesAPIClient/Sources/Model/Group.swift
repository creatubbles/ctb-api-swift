//
//  Group.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 09.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class Group
{
    let identifier: Int
    let name: String
    let taggingsCount: Int
    
    init(builder: GroupModelBuilder)
    {
        identifier = builder.identifier!
        name = builder.name!
        taggingsCount = builder.taggingsCount!
    }
}
