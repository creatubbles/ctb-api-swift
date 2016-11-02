//
//  FetchToybooCreationResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 02.11.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class FetchToybooCreationResponseHandler: ResponseHandler
{
    private let completion: ToybooCreationClosure?
    
    init(completion: ToybooCreationClosure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(_ response: Dictionary<String, AnyObject>?, error: Error?)
    {
        if let response = response,
            let mapper = Mapper<ToybooCreationMapper>().map(JSON: response["data"] as! [String : Any])
        {
            let metadata = MappingUtils.metadataFromResponse(response)
            let dataMapper = MappingUtils.dataIncludeMapperFromResponse(response, metadata: metadata)
            let creation = ToybooCreation(mapper: mapper, dataMapper: dataMapper, metadata: metadata)
            
            executeOnMainQueue { self.completion?(creation, ErrorTransformer.errorFromResponse(response, error: error)) }
        }
        else
        {
            executeOnMainQueue { self.completion?(nil, ErrorTransformer.errorFromResponse(response, error: error)) }
        }
    }
}
