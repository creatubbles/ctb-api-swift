//
//  UpdateGalleryData.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 20.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc public class UpdateGalleryData: NSObject {
    public let identifier: String
    public let name: String?
    public let galleryDescription: String?
    public let openForAll: Bool?
    
    public init(galleryId: String, name: String?, galleryDescription: String?, openForAll: Bool?)
    {
        self.identifier = galleryId
        self.name = name
        self.galleryDescription = galleryDescription
        self.openForAll = openForAll
    }
}