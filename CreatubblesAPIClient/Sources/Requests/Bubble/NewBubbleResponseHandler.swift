//
//  NewBubbleResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 17.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class NewBubbleResponseHandler: ResponseHandler
{
    private let completion: BubbleClousure?
    
    init(completion: BubbleClousure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(response: Dictionary<String, AnyObject>?, error: ErrorType?)
    {
        if  let response = response,
            let mapper = Mapper<BubbleMapper>().map(response["data"])
        {
            let metadata = MappingUtils.metadataFromResponse(response)            
            let dataMapper = MappingUtils.dataIncludeMapperFromResponse(response, metadata: metadata)
            
            let bubble = Bubble(mapper: mapper, dataMapper: dataMapper)
            completion?(bubble, ErrorTransformer.errorFromResponse(response, error: error))
        }
        else
        {
            completion?(nil, ErrorTransformer.errorFromResponse(response, error: error))
        }
    }
}