//
//  NewCreationData.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 23.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

@objc
public class NewCreationData: NSObject
{
    public var image: UIImage
    public var name: String? = nil
    public var reflectionText: String? = nil
    public var reflectionVideoUrl: String? = nil
    public var galleryId: String? = nil
    public var creatorIds: Array<String>? = nil
    public var creationYear: Int? = nil
    public var creationMonth: Int? = nil
    
    public init(image: UIImage)
    {
        self.image = image
    }
}
