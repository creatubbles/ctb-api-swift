//
//  AvatarSuggestionsResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 10.11.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class AvatarSuggestionsFetchResponseHandler: ResponseHandler
{
    fileprivate let completion: AvatarSuggestionsClosure?
    
    init(completion: AvatarSuggestionsClosure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(_ response: Dictionary<String, AnyObject>?, error: Error?)
    {
        if  let response = response,
            let mappers = Mapper<AvatarSuggestionMapper>().mapArray(JSONObject: response["data"])
        {
            let metadata = MappingUtils.metadataFromResponse(response)
            let dataMapper = MappingUtils.dataIncludeMapperFromResponse(response, metadata: metadata)
            let avatarSuggestions = mappers.map({AvatarSuggestion(mapper: $0, dataMapper: dataMapper, metadata: metadata)})
            
            executeOnMainQueue { self.completion?(avatarSuggestions, ErrorTransformer.errorFromResponse(response, error: error)) }
        }
        else
        {
            executeOnMainQueue { self.completion?(nil, ErrorTransformer.errorFromResponse(response, error: error)) }
        }
    }

}
