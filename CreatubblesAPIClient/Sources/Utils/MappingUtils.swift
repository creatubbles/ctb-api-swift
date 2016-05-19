//
//  MappingUtils.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 19.05.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class MappingUtils
{
    class func relationshipFromMapper(mapper: RelationshipMapper?) -> Relationship?
    {
        return mapper == nil ? nil : Relationship(mapper: mapper!)
    }
    
    class func objectFromMapper<T: Identifiable>(mapper: DataIncludeMapper?, relationship: Relationship?, type: T.Type) -> T?
    {
        guard   let mapper = mapper,
        let relationship = relationship
        else { return nil }
        return mapper.objectWithIdentifier(relationship.identifier, type: T.self)
    }
}
