//
//  NewGalleryResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 11.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class NewGalleryResponseHandler: ResponseHandler
{
    private let completion: GalleryClousure?
    init(completion: GalleryClousure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(response: Dictionary<String, AnyObject>?, error: NSError?)
    {
        if let response = response,
           let builder = Mapper<GalleryModelBuilder>().map(response["data"])
        {
            let gallery = Gallery(builder: builder)
            completion?(gallery, error)
        }
        else
        {
            completion?(nil, error)
        }
    }
}
