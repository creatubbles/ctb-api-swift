//
//  NotificationsFetchResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 07.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class NotificationsFetchResponseHandler: ResponseHandler
{
    private let completion: NotificationsClosure?
    
    init(completion: NotificationsClosure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(response: Dictionary<String, AnyObject>?, error: ErrorType?)
    {
        if  let response = response,
            let mappers = Mapper<NotificationMapper>().mapArray(response["data"])
        {
            let metadata = MappingUtils.metadataFromResponse(response)
            let pageInfo = MappingUtils.pagingInfoFromResponse(response)
            let notificationMetadata = MappingUtils.notificationMetadataFromResponse(response)
            let dataMapper = MappingUtils.dataIncludeMapperFromResponse(response, metadata: metadata)
            let objects    = mappers.map({ Notification(mapper: $0, dataMapper: dataMapper, notificationMetadata: notificationMetadata) }).filter({ $0.type != .Unknown })
            
            executeOnMainQueue { self.completion?(objects, pageInfo, ErrorTransformer.errorFromResponse(response ,error: error)) }
        }
        else
        {
            executeOnMainQueue { self.completion?(nil, nil, ErrorTransformer.errorFromResponse(response, error: error)) }
        }
    }
}
