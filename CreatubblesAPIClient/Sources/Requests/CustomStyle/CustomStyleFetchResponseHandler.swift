//
//  CustomStyleFetchResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 03.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class CustomStyleFetchResponseHandler: ResponseHandler
{
    private let completion: CustomStyleClosure?
    
    init(completion: CustomStyleClosure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(response: Dictionary<String, AnyObject>?, error: ErrorType?)
    {
        if  let response = response,
            let mapper = Mapper<CustomStyleMapper>().map(response["data"])
        {
            let metadataMapper = Mapper<MetadataMapper>().map(response["meta"])
            let metadata: Metadata? = metadataMapper != nil ? Metadata(mapper: metadataMapper!) : nil
            
            let includedResponse = response["included"] as? Array<Dictionary<String, AnyObject>>
            let dataMapper: DataIncludeMapper? = includedResponse == nil ? nil : DataIncludeMapper(includeResponse: includedResponse!, metadata: metadata)
            
            let style = CustomStyle(mapper: mapper, dataMapper: dataMapper)
            completion?(style, ErrorTransformer.errorFromResponse(response, error: error))
        }
        else
        {
            completion?(nil, ErrorTransformer.errorFromResponse(response, error: error))
        }
    }
}
