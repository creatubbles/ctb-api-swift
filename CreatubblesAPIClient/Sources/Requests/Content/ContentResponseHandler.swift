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
    private let completion: ContentEntryClosure?
    
    init(completion: ContentEntryClosure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(response: Dictionary<String, AnyObject>?, error: ErrorType?)
    {
        if  let response = response,
            let mappers = Mapper<ContentEntryMapper>().mapArray(response["data"])
        {
            let metadataMapper = Mapper<MetadataMapper>().map(response["meta"])
            let metadata: Metadata? = metadataMapper != nil ? Metadata(mapper: metadataMapper!) : nil
            
            let includedResponse = response["included"] as? Array<Dictionary<String, AnyObject>>
            let dataMapper: DataIncludeMapper? = includedResponse == nil ? nil : DataIncludeMapper(includeResponse: includedResponse!, metadata: metadata)
         
            
            let entries = mappers.map({ ContentEntry(mapper: $0, dataMapper: dataMapper) }).filter({ $0.type != .None })
            
            let pageInfoMapper = Mapper<PagingInfoMapper>().map(response["meta"])!
            let pageInfo = PagingInfo(mapper: pageInfoMapper)
            
            completion?(entries, pageInfo, ErrorTransformer.errorFromResponse(response ,error: error))
        }
        else
        {
            completion?(nil, nil, ErrorTransformer.errorFromResponse(response, error: error))
        }
    }
}
