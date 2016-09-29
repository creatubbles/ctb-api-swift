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
    fileprivate let completion: CommentsClosure?
    
    init(completion: CommentsClosure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(_ response: Dictionary<String, AnyObject>?, error: Error?)
    {
        if  let response = response,
            let mappers = Mapper<CommentMapper>().mapArray(response["data"])
        {
            let metadata = MappingUtils.metadataFromResponse(response)
            let pageInfo = MappingUtils.pagingInfoFromResponse(response)
            let dataMapper = MappingUtils.dataIncludeMapperFromResponse(response, metadata: metadata)
            let comments = mappers.map({ Comment(mapper: $0, dataMapper: dataMapper, metadata: metadata) })
                    
            executeOnMainQueue { self.completion?(comments, pageInfo, ErrorTransformer.errorFromResponse(response, error: error)) }
        }
        else
        {
            executeOnMainQueue { self.completion?(nil, nil, ErrorTransformer.errorFromResponse(response, error: error)) }
        }
    }
}
