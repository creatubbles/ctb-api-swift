//
// Created by Michal Miedlarz on 31.03.2016.
// Copyright (c) 2016 Nomtek. All rights reserved.
//

import Foundation
import ObjectMapper

class RelationshipMapper: Mappable
{
    var type: String?
    var identifier: String?

    required init?(_ map: Map)
    {

    }

    func mapping(map: Map)
    {
        type <- map["type"]
        identifier <- map["id"]
    }
}