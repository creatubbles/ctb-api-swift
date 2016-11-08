//
//  NameTranslationObject.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 29.08.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
@objc
open class NameTranslationObject: NSObject
{
    open let code: String?
    open let name: String?
    open let original: Bool?
    
    init(mapper: NameTranslationObjectMapper, dataMapper: DataIncludeMapper? = nil, metadata: Metadata? = nil)
    {
        code = mapper.code
        name = mapper.name
        original = mapper.original
    }
    
    init(nameTranslationObjectEntity: NameTranslationObjectEntity)
    {
        code = nameTranslationObjectEntity.code
        name = nameTranslationObjectEntity.name
        original = nameTranslationObjectEntity.original.value
    }
}
