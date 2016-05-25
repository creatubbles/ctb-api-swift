//
//  BubblesFetchResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 16.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class BubblesFetchResponseHandler: ResponseHandler
{
    private let completion: BubblesClousure?
    
    init(completion: BubblesClousure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(response: Dictionary<String, AnyObject>?, error: ErrorType?)
    {
        if  let response = response,
            let mappers = Mapper<BubbleMapper>().mapArray(response["data"])
        {
            let includedResponse = response["included"] as? Array<Dictionary<String, AnyObject>>
            let dataMapper: DataIncludeMapper? = includedResponse == nil ? nil : DataIncludeMapper(includeResponse: includedResponse!)
            let bubbles = mappers.map({Bubble(mapper: $0, dataMapper: dataMapper)})                        
            
            let pageInfoMapper = Mapper<PagingInfoMapper>().map(response["meta"])!
            let pageInfo = PagingInfo(mapper: pageInfoMapper)
            
            completion?(bubbles, pageInfo, ErrorTransformer.errorFromResponse(response, error: error))
        }
        else
        {
            completion?(nil, nil, ErrorTransformer.errorFromResponse(response, error: error))
        }
    }
}
