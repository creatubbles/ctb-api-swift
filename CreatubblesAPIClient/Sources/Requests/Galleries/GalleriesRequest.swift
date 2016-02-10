//
//  GalleriesRequest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 10.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class GalleriesRequest: Request
{
    override var method: RequestMethod   { return .GET }
    override var endpoint: String
    {
        if let galleryId = galleryId
        {
            return "galleries/"+galleryId
        }
        return "galleries"
    }
    
    override var parameters: Dictionary<String, AnyObject>
    {
        return Dictionary<String, AnyObject>()
    }
    
    private let galleryId: String?
    init(galleryId: String? = nil)
    {
        self.galleryId = galleryId
    }
}
