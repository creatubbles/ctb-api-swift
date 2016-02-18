//
//  GalleriesResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 10.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class GalleriesResponseHandler: ResponseHandler
{
    private let completion: GalleriesClousure?
    init(completion: GalleriesClousure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(response: Dictionary<String, AnyObject>?, error: NSError?)
    {
        if  let response = response,
            let builders = Mapper<GalleryModelBuilder>().mapArray(response["data"])
        {
            var galleries = Array<Gallery>()
            for builder in builders
            {
                galleries.append(Gallery(builder: builder))
            }
            completion?(galleries, error)
        }
        else if let response = response,
                let builder = Mapper<GalleryModelBuilder>().map(response["data"])
        {
            let gallery = Gallery(builder: builder)
            completion?([gallery], error)
        }
        else
        {
            completion?(nil, error)
        }
    }
}
