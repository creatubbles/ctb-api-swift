//
// Created by Michal Miedlarz on 31.03.2016.
// Copyright (c) 2016 Nomtek. All rights reserved.
//

import Foundation

open class Relationship
{
    open let type: String
    open let identifier: String

    init(mapper: RelationshipMapper)
    {
        type = mapper.type!
        identifier = mapper.identifier!
    }
}
