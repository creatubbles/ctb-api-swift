//
//  ReportGalleryRequest.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 14.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class ReportGalleryRequest: Request {
    
    override var method: RequestMethod  { return .post }
    override var endpoint: String       { return "galleries/\(galleryId)/report" }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    
    fileprivate let galleryId: String
    fileprivate let message: String
    
    init(galleryId: String, message: String) {
        self.galleryId = galleryId
        self.message = message
    }
    
    fileprivate func prepareParameters() -> Dictionary<String,AnyObject> {
        var params = Dictionary<String,AnyObject>()
        params["message"] = message as AnyObject?
        
        return params
    }
}
