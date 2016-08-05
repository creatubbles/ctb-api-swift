//
//  GroupCreatorsResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 03.08.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class GroupCreatorsResponseHandler: ResponseHandler
{
    private let completion: UsersClosure?
    
    init(completion: UsersClosure?) {
        self.completion = completion
    }
    
    override func handleResponse(response: Dictionary<String, AnyObject>?, error: ErrorType?) {
        
        if  let response = response,
            let usersMapper = Mapper<UserMapper>().mapArray(response["data"]) {
            
            let metadata = MappingUtils.metadataFromResponse(response)
            let pageInfo = MappingUtils.pagingInfoFromResponse(response)
            let dataMapper = MappingUtils.dataIncludeMapperFromResponse(response, metadata: metadata)
            let users = usersMapper.map({ User(mapper: $0, dataMapper: dataMapper, metadata: metadata)})
            
            executeOnMainQueue { self.completion?(users, pageInfo, ErrorTransformer.errorFromResponse(response, error: error)) }
        } else {
            executeOnMainQueue { self.completion?(nil, nil, ErrorTransformer.errorFromResponse(response, error: error)) }
        }
    }
}