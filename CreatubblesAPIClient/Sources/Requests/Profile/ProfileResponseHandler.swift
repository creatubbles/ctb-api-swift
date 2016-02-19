//
//  ProfileResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 09.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class ProfileResponseHandler: ResponseHandler
{
    private let completion: UserClousure?
    
    init(completion: UserClousure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(response: Dictionary<String, AnyObject>?, error: ErrorType?)
    {
        if  let response = response,
            let userBuilder = Mapper<UserModelBuilder>().map(response["data"])
        {
            let user = User(builder: userBuilder)
            completion?(user, error)
        }
        else
        {
            completion?(nil, error)
        }
    }
}
