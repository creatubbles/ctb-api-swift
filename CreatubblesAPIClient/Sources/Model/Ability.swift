//
//  Ability.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 01.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
public class Ability: NSObject
{
    public let identifier: String
    public let type: String
    public let resourceType: String
    public let resourceIdentifier: String
    public let operation: String
    public let permission: Bool
    
    init(mapper: AbilityMapper)
    {
        identifier = mapper.identifier!
        type = mapper.type!
        resourceType = mapper.resourceType!
        resourceIdentifier = mapper.resourceIdentifier!
        operation = mapper.operation!
        permission = mapper.permission!
    }
}
