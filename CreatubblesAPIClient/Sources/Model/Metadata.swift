//
//  Metadata.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 01.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class Metadata: NSObject
{
    let bubbledCreationIdentifiers: Array<String>
    let bubbledUserIdentifiers: Array<String>
    let bubbledGalleryIdentifiers: Array<String>
    let abilities: Array<Ability>
    
    init(mapper: MetadataMapper)
    {
        bubbledCreationIdentifiers = mapper.bubbledCreationIdentifiers ?? []
        bubbledUserIdentifiers = mapper.bubbledUserIdentifiers ?? []
        bubbledGalleryIdentifiers = mapper.bubbledGalleryIdentifiers ?? []
        abilities = mapper.abilityMappers?.map({ Ability(mapper: $0)}).filter({ $0.operation != .Unknown }) ?? []
    }
}
