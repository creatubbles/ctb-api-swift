//
//  GroupsResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 30.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class GroupsResponseHandler: ResponseHandler
{
    fileprivate let completion: GroupsClosure?
    
    init(completion: GroupsClosure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(_ response: Dictionary<String, AnyObject>?, error: Error?)
    {
        if  let response = response,
            let mappers = Mapper<GroupMapper>().mapArray(JSONObject: response["data"])
        {
            let metadata = MappingUtils.metadataFromResponse(response)
            let dataMapper = MappingUtils.dataIncludeMapperFromResponse(response, metadata: metadata)
            let objects    = mappers.map({ Group(mapper: $0, dataMapper: dataMapper) })
            
            executeOnMainQueue { self.completion?(objects, ErrorTransformer.errorFromResponse(response, error: error)) }
        }
        else
        {
            executeOnMainQueue { self.completion?(nil, ErrorTransformer.errorFromResponse(response, error: error)) }
        }
    }
}
