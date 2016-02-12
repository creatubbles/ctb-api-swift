//
//  NewCreationResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 12.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class NewCreationResponseHandler: ResponseHandler
{
    private let completion: (creation: Creation?, error: ErrorType?) -> Void
    init(completion: (creation: Creation?, error: ErrorType?) -> Void)
    {
        self.completion = completion
    }
    
    override func handleResponse(response: Dictionary<String, AnyObject>?, error: NSError?)
    {
        if  let response = response,
            let builder = Mapper<CreationModelBuilder>().map(response["data"])
        {
            let creation = Creation(builder: builder)
            completion(creation: creation, error: error)
        }
        else
        {
            completion(creation: nil, error: error)
        }
    }
}
