//
//  GroupResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 30.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class GroupResponseHandler: ResponseHandler
{
    fileprivate let completion: GroupClosure?
    
    init(completion: GroupClosure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(_ response: Dictionary<String, AnyObject>?, error: Error?)
    {
        if  let response = response,
            let mapper = Mapper<GroupMapper>().map(JSON: response["data"] as! [String : Any])
        {
            let metadata = MappingUtils.metadataFromResponse(response)
            let dataMapper = MappingUtils.dataIncludeMapperFromResponse(response, metadata: metadata)
            let group    =  Group(mapper: mapper, dataMapper: dataMapper)
            
            executeOnMainQueue { self.completion?(group, ErrorTransformer.errorFromResponse(response, error: error)) }
        }
        else
        {
            executeOnMainQueue { self.completion?(nil, ErrorTransformer.errorFromResponse(response, error: error)) }
        }
    }
}
