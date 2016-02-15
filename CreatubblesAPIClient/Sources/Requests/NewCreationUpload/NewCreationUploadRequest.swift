//
//  NewCreationUploadRequest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 15.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

enum UploadExtension: String
{
    case PNG = "png"
    case JPG = "jpg"
    case JPEG = "jpeg"
    case H264 = "h64"
    case MPEG4 = "mpeg4"
    case WMV = "wmv"
    case WEBM = "webm"
    case FLV = "flv"
    case OGG = "ogg"
    case OGV = "ogv"
    case MP4 = "mp4"
    case M4V = "m4v"
    case MOV = "mov"
}

class NewCreationUploadRequest: Request
{
    override var method: RequestMethod  { return .POST }
    override var endpoint: String       { return "creations/"+creationId+"/uploads" }
    override var parameters: Dictionary<String, AnyObject>
    {
        if let ext = creationExtension
        {
            return ["extension": ext.rawValue]
        }
        return Dictionary<String, AnyObject>()
    }
    
    private let creationId: String
    private let creationExtension: UploadExtension?
    
    init(creationId: String, creationExtension: UploadExtension? = nil)
    {
        self.creationId = creationId
        self.creationExtension = creationExtension
    }
}
