//
// Created by Michal Miedlarz on 31.03.2016.
// Copyright (c) 2016 Nomtek. All rights reserved.
//

import Foundation

class Relationship
{
    let type: String
    let identifier: String

    init(mapper: RelationshipMapper)
    {
        type = mapper.type!
        identifier = mapper.identifier!
    }
}
