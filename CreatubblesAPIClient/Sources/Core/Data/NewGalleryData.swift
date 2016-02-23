//
//  NewGalleryData.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 23.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
public class NewGalleryData: NSObject
{
    public let name: String
    public let galleryDescription: String
    public let openForAll: Bool
    public var ownerId: String?
    
    public init(name: String, galleryDescription: String, openForAll: Bool, ownerId: String?)
    {
        self.name = name
        self.galleryDescription = galleryDescription
        self.openForAll = openForAll
        self.ownerId = ownerId
    }
}
