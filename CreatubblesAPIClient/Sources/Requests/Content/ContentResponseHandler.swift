//
//  ContentResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 19.05.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class ContentResponseHandler: ResponseHandler
{
    fileprivate let completion: ContentEntryClosure?
    fileprivate let validator: Validatable = ContentDataFilter()
    
    init(completion: ContentEntryClosure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(_ response: Dictionary<String, AnyObject>?, error: Error?)
    {
        var validEntries: [ContentEntry] = []
        var invalidEntries: [ContentEntry] = []
        
        if  let response = response,
            let mappers = Mapper<ContentEntryMapper>().mapArray(JSONArray: response["data"] as! [[String : Any]])
        {
            let metadata = MappingUtils.metadataFromResponse(response)
            let pageInfo = MappingUtils.pagingInfoFromResponse(response)
            let dataMapper = MappingUtils.dataIncludeMapperFromResponse(response, metadata: metadata)
            
            mappers.forEach({ (mapper) in
                let contentEntry = ContentEntry(mapper: mapper, dataMapper: dataMapper)
                
                validator.isValid(contentEntry) ? validEntries.append(contentEntry) : invalidEntries.append(contentEntry)
            })
            
            let responseData = ResponseData(objects: validEntries, rejectedObjects: invalidEntries, pagingInfo: pageInfo, error: ErrorTransformer.errorFromResponse(response ,error: error))
            executeOnMainQueue { self.completion?(responseData) }
        }
        else
        {
            let responseData = ResponseData(objects: validEntries, rejectedObjects: validEntries, pagingInfo: nil, error: ErrorTransformer.errorFromResponse(response ,error: error))
            executeOnMainQueue { self.completion?(responseData) }
        }
    }
}
