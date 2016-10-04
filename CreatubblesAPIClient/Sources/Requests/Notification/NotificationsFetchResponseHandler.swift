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
    fileprivate let completion: NotificationsClosure?
    
    init(completion: NotificationsClosure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(_ response: Dictionary<String, AnyObject>?, error: Error?)
    {
        if  let response = response,
            let mappers = Mapper<NotificationMapper>().mapArray(JSONArray: response["data"] as! [[String : Any]])
        {
            let metadata = MappingUtils.metadataFromResponse(response)
            let pageInfo = MappingUtils.pagingInfoFromResponse(response)
            let notificationMetadata = MappingUtils.notificationMetadataFromResponse(response)
            let dataMapper = MappingUtils.dataIncludeMapperFromResponse(response, metadata: metadata)
            let objects    = mappers.map({ Notification(mapper: $0, dataMapper: dataMapper) }).filter({ $0.type != .unknown })
            
            executeOnMainQueue { self.completion?(objects, notificationMetadata?.totalUnreadCount ,pageInfo, ErrorTransformer.errorFromResponse(response ,error: error)) }
        }
        else
        {
            executeOnMainQueue { self.completion?(nil, nil, nil, ErrorTransformer.errorFromResponse(response, error: error)) }
        }
    }
}
