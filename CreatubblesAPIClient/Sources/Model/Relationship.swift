//
// Created by Michal Miedlarz on 31.03.2016.
// Copyright (c) 2016 Nomtek. All rights reserved.
//

import Foundation

public class Relationship
{
    public let type: String
    public let identifier: String

    init(mapper: RelationshipMapper)
    {
        type = mapper.type!
        identifier = mapper.identifier!
    }
}
