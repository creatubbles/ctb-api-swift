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
    private let completion: GroupsClosure?
    
    init(completion: GroupsClosure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(response: Dictionary<String, AnyObject>?, error: ErrorType?)
    {
        if  let response = response,
            let mappers = Mapper<GroupMapper>().mapArray(response["data"])
        {
            let metadata = MappingUtils.metadataFromResponse(response)
            let pageInfo = MappingUtils.pagingInfoFromResponse(response)
            let dataMapper = MappingUtils.dataIncludeMapperFromResponse(response, metadata: metadata)
            let objects    = mappers.map({ Group(mapper: $0, dataMapper: dataMapper) })
            
            executeOnMainQueue { self.completion?(objects, pageInfo, ErrorTransformer.errorFromResponse(response, error: error)) }
        }
        else
        {
            executeOnMainQueue { self.completion?(nil, nil, ErrorTransformer.errorFromResponse(response, error: error)) }
        }
    }
}
