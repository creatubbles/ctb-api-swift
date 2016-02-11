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
    private let completion: (gallery: Gallery?, error: ErrorType?) -> Void
    init(completion: (gallery: Gallery?, error: ErrorType?) -> Void)
    {
        self.completion = completion
    }
    
    override func handleResponse(response: Dictionary<String, AnyObject>?, error: NSError?)
    {
        if let response = response,
           let builder = Mapper<GalleryModelBuilder>().map(response["data"])
        {
            let gallery = Gallery(builder: builder)
            completion(gallery: gallery, error: error)
        }
        else
        {
            completion(gallery: nil, error: error)
        }
    }
}
