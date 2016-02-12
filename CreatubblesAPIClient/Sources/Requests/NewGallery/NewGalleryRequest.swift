//
//  NewGalleryRequest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 11.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class NewGalleryRequest: Request
{
    override var method: RequestMethod  { return .POST }
    override var endpoint: String       { return "galleries" }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    
    private let name: String
    private let galleryDescription: String
    private let openForAll: Bool
    private let ownerId: String?
    
    init(name: String, galleryDescription: String, openForAll: Bool = false, ownerId: String? = nil)
    {
        self.name = name
        self.galleryDescription = galleryDescription
        self.openForAll = openForAll
        self.ownerId = ownerId
    }
    
    private func prepareParameters() -> Dictionary<String, AnyObject>
    {
        var params = Dictionary<String, AnyObject>()
        params["name"] = name
        params["description"] = galleryDescription
        params["open_for_all"] = openForAll ? 1 : 0
        if let ownerId = ownerId
        {
            params["owner_id"] = ownerId
        }
        
        return params
    }
}
