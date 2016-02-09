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
    private let completion: (user: User?, error:NSError?) -> Void
    
    init(completion: (user: User?, error:NSError?) -> Void)
    {
        self.completion = completion
    }
    
    override func handleResponse(response: Dictionary<String, AnyObject>?, error: NSError?)
    {
        if  let response = response,
            let userBuilder = Mapper<UserModelBuilder>().map(response)
        {
            let user = User(builder: userBuilder)
            completion(user: user, error: error)
        }
        else
        {
            completion(user: nil, error: error)
        }
    }
}
