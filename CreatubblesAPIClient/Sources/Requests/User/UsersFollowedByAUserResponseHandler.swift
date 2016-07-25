//
//  UsersFollowedByAUserResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 20.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class UsersFollowedByAUserResponseHandler: ResponseHandler
{
    private let usersCompletion: UsersClosure?
    private let countCompletion: UsersCountClosure?
    
    init(completion: UsersClosure?)
    {
        self.usersCompletion = completion
        self.countCompletion = nil
    }
    
    init(completion: UsersCountClosure?)
    {
        self.countCompletion = completion
        self.usersCompletion = nil
    }
    
    override func handleResponse(response: Dictionary<String, AnyObject>?, error: ErrorType?)
    {
        if let completion = self.usersCompletion
        {
            if  let response = response,
                let usersMapper = Mapper<UserMapper>().mapArray(response["data"])
            {
                let metadata = MappingUtils.metadataFromResponse(response)
                let pageInfo = MappingUtils.pagingInfoFromResponse(response)
                let dataMapper = MappingUtils.dataIncludeMapperFromResponse(response, metadata: metadata)
                let users = usersMapper.map({ User(mapper: $0, dataMapper: dataMapper, metadata: metadata)})
                
                executeOnMainQueue { completion(users, pageInfo, ErrorTransformer.errorFromResponse(response, error: error)) }
            }
            else
            {
                executeOnMainQueue { completion(nil, nil, ErrorTransformer.errorFromResponse(response, error: error)) }
            }
        }
        else if let completion = self.countCompletion
        {
            if  let response = response,
                let usersMapper = Mapper<UserMapper>().mapArray(response["data"])
            {
                let metadata = MappingUtils.metadataFromResponse(response)
                let dataMapper = MappingUtils.dataIncludeMapperFromResponse(response, metadata: metadata)
                let users = usersMapper.map({ User(mapper: $0, dataMapper: dataMapper, metadata: metadata)})
                let usersCount = users.count
                executeOnMainQueue { completion(usersCount, ErrorTransformer.errorFromResponse(response, error: error)) }
            }
            else
            {
                executeOnMainQueue { completion(nil, ErrorTransformer.errorFromResponse(response, error: error)) }
            }
        }
    }
}
