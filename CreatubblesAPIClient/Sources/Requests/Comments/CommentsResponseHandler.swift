//
//  CommentsResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 17.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class CommentsResponseHandler: ResponseHandler
{

    private let completion: CommentsClosure?
    
    init(completion: CommentsClosure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(response: Dictionary<String, AnyObject>?, error: ErrorType?)
    {
        if  let response = response,
            let mappers = Mapper<CommentMapper>().mapArray(response["data"])
        {
            var comments = Array<Comment>()
            for mapper in mappers
            {
                comments.append(Comment(mapper: mapper))
            }
            
            completion?(comments, ErrorTransformer.errorFromResponse(response, error: error))
        }
        else
        {
            completion?(nil, ErrorTransformer.errorFromResponse(response, error: error))
        }
    }
}
