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
    private let completion: CreationsClousure?
    
    init(completion: CreationsClousure?)
    {
        self.completion = completion
    }

    override func handleResponse(response: Dictionary<String, AnyObject>?, error: ErrorType?)
    {
        if  let response = response,
            let builders = Mapper<CreationModelBuilder>().mapArray(response["data"])
        {
            var creations = Array<Creation>()
            for builder in builders
            {
                creations.append(Creation(builder: builder))
            }
            
            let pageInfoBuilder = Mapper<PagingInfoModelBuilder>().map(response["meta"])!
            let pageInfo = PagingInfo(builder: pageInfoBuilder)
            
            completion?(creations,pageInfo, error)
        }
        else if let response = response,
            let builder = Mapper<CreationModelBuilder>().map(response["data"])
        {
            let creation = Creation(builder: builder)
            completion?([creation], nil, error)
        }
        else
        {
            completion?(nil, nil, error)
        }
    }

}
