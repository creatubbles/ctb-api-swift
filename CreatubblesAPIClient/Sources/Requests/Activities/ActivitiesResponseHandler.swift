//
//  ActivitiesResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 22.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class ActivitiesResponseHandler: ResponseHandler {
    fileprivate let completion: ActivitiesClosure?
    
    init(completion: ActivitiesClosure?) {
        self.completion = completion
    }
    
    override func handleResponse(_ response: Dictionary<String, AnyObject>?, error: Error?) {
        if  let response = response, let mappers = Mapper<ActivityMapper>().mapArray(response["data"]) {
            let metadata = MappingUtils.metadataFromResponse(response)
            let pageInfo = MappingUtils.pagingInfoFromResponse(response)
            let dataMapper = MappingUtils.dataIncludeMapperFromResponse(response, metadata: metadata)
            let activities = mappers.map({ Activity(mapper: $0, dataMapper: dataMapper, metadata: metadata) })
            
            executeOnMainQueue { self.completion?(activities, pageInfo, ErrorTransformer.errorFromResponse(response, error: error)) }
        } else {
            executeOnMainQueue { self.completion?(nil, nil, ErrorTransformer.errorFromResponse(response, error: error)) }
        }
    }
}
