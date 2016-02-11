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
    private let completion: (galleries: Array<Gallery>?, error: ErrorType?) -> Void        
    init(completion: (galleries: Array<Gallery>?, error: ErrorType?) -> Void)
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
            completion(galleries: galleries, error: error)
        }
        else if let response = response,
                let builder = Mapper<GalleryModelBuilder>().map(response["data"])
        {
            let gallery = Gallery(builder: builder)
            completion(galleries: [gallery], error: error)
        }
        else
        {
            completion(galleries: nil, error: error)
        }
    }
}
