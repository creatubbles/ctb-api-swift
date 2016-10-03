//
//  UpdateGalleryRequest.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 20.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class UpdateGalleryRequest: Request {
    override var method: RequestMethod   { return .PUT }
    override var endpoint: String { return "galleries/\(data.identifier)" }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    private let data: UpdateGalleryData
    
    init(data: UpdateGalleryData)
    {
        self.data = data
    }

    private func prepareParameters() -> Dictionary<String,AnyObject>
    {
        var params = Dictionary<String, AnyObject>()
        
        if let name = data.name
        {
            params["name"] = name
        }
        if let galleryDescription = data.galleryDescription
        {
            params["description"] = galleryDescription
        }
        if let openForAll = data.openForAll
        {
            params["open_for_all"] = openForAll
        }
        return params
    }
}