//
//  UserAccountDetailsResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 21.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class UserAccountDetailsResponseHandler: ResponseHandler
{
    fileprivate let completion: UserAccountDetailsClosure?
    init(completion: UserAccountDetailsClosure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(_ response: Dictionary<String, AnyObject>?, error: Error?)
    {
        if  let response = response,
            let mapper = Mapper<UserAccountDetailsMapper>().map(response["data"])
        {
            let details = UserAccountDetails(mapper: mapper)
            executeOnMainQueue { self.completion?(details, ErrorTransformer.errorFromResponse(response, error: error)) }
        }
        else
        {
            executeOnMainQueue { self.completion?(nil, ErrorTransformer.errorFromResponse(response, error: error)) }
        }
    }
}
