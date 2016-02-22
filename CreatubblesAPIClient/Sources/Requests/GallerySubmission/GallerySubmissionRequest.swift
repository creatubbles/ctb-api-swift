//
//  GallerySubmissionRequest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 19.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class GallerySubmissionRequest: Request
{
    override var method: RequestMethod   { return .POST }
    override var endpoint: String { return "gallery_submissions" }
    override var parameters: Dictionary<String, AnyObject>
    {
        return [
            "gallery_id" : galleryId,
            "creation_id" : creationid
        ]
    }

    private let galleryId: String
    private let creationid: String
    
    init(galleryId: String, creationId: String)
    {
        self.galleryId = galleryId
        self.creationid = creationId
    }
}
