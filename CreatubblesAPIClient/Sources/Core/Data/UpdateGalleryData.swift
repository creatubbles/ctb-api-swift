//
//  UpdateGalleryData.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 20.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc open class UpdateGalleryData: NSObject {
    open let identifier: String
    open let name: String?
    open let galleryDescription: String?
    
    public init(galleryId: String, name: String?, galleryDescription: String?) {
        self.identifier = galleryId
        self.name = name
        self.galleryDescription = galleryDescription
    }
}
