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
            let metadata = MappingUtils.metadataFromResponse(response)
            let pageInfo = MappingUtils.pagingInfoFromResponse(response)
            let dataMapper = MappingUtils.dataIncludeMapperFromResponse(response, metadata: metadata)
            let comments = mappers.map({ Comment(mapper: $0, dataMapper: dataMapper) })
                    
            completion?(comments, pageInfo, ErrorTransformer.errorFromResponse(response, error: error))
        }
        else
        {
            completion?(nil, nil, ErrorTransformer.errorFromResponse(response, error: error))
        }
    }
}