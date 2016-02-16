//
//  FetchCreationsResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 16.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class FetchCreationsResponseHandler: ResponseHandler
{
    private let completion: (creations: Array<Creation>?, error: ErrorType?) -> Void
    
    init(completion: (creations: Array<Creation>?, error: ErrorType?) -> Void)
    {
        self.completion = completion
    }

    override func handleResponse(response: Dictionary<String, AnyObject>?, error: NSError?)
    {
        if  let response = response,
            let builders = Mapper<CreationModelBuilder>().mapArray(response["data"])
        {
            var creations = Array<Creation>()
            for builder in builders
            {
                creations.append(Creation(builder: builder))
            }
            completion(creations: creations, error: error)
        }
        else if let response = response,
            let builder = Mapper<CreationModelBuilder>().map(response["data"])
        {
            let creation = Creation(builder: builder)
            completion(creations: [creation], error: error)
        }
        else
        {
            completion(creations: nil, error: error)
        }
    }

}
