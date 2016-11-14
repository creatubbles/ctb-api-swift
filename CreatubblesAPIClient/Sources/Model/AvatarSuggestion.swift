//
//  AvatarSuggestion.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 10.11.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
open class AvatarSuggestion: NSObject
{
    open let id: String
    open let avatarURL: String
    
    init(mapper: AvatarSuggestionMapper, dataMapper: DataIncludeMapper? = nil, metadata: Metadata? = nil)
    {
        id = mapper.id!
        avatarURL = mapper.avatarURL!
    }
}
