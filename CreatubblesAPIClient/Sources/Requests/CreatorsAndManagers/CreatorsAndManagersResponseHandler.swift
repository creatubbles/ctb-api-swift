//
//  CreatorsAndManagersResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 09.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class CreatorsAndManagersResponseHandler: ResponseHandler
{
    private let completion: UsersClousure?
    init(completion: UsersClousure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(response: Dictionary<String, AnyObject>?, error: ErrorType?)
    {
        if  let response = response,
            let usersBuilder = Mapper<UserModelBuilder>().mapArray(response["data"])
        {
            var users = Array<User>()
            for builder in usersBuilder
            {
                users.append(User(builder: builder))
            }
            
            let pageInfoBuilder = Mapper<PagingInfoModelBuilder>().map(response["meta"])!
            let pageInfo = PagingInfo(builder: pageInfoBuilder)

            completion?(users, pageInfo, error)
        }
        else
        {
            completion?(nil, nil, error)
        }
    }
}
