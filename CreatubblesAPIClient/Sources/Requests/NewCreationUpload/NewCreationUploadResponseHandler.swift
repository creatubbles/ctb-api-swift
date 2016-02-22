//
//  NewCreationUploadResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 15.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class NewCreationUploadResponseHandler: ResponseHandler
{
    private let completion: (creationUpload: CreationUpload?, error: ErrorType?) -> Void
    init(completion: (creationUpload: CreationUpload?, error: ErrorType?) -> Void)
    {
        self.completion = completion
    }
    
    override func handleResponse(response: Dictionary<String, AnyObject>?, error: ErrorType?)
    {
        if  let response = response,
            let builder = Mapper<CreationUploadModelBuilder>().map(response["data"])
        {
            let creationUpload = CreationUpload(builder: builder)
            completion(creationUpload: creationUpload, error: error)
        }
        else
        {
            completion(creationUpload: nil, error: error)
        }
    }
}
