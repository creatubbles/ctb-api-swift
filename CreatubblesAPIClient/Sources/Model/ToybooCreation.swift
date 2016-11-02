//
//  ToybooCreation.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 02.11.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
public class ToybooCreation: NSObject
{
    public let identifier: String
    public let uzpbUrl: String
    public let contentUrl: String
    
    init(mapper: ToybooCreationMapper, dataMapper: DataIncludeMapper? = nil, metadata: Metadata? = nil)
    {
        self.identifier = mapper.identifier!
        self.uzpbUrl = mapper.uzpbUrl!
        self.contentUrl = mapper.contentUrl!
    }
}
