//
//  PartnerApplicationsSearchResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 04.08.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class PartnerApplicationsSearchResponseHandler: ResponseHandler
{
    fileprivate let completion: PartnerApplicationsClosure?
    init(completion: PartnerApplicationsClosure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(_ response: Dictionary<String, AnyObject>?, error: Error?)
    {
        if  let response = response,
            let partnerApplicationsMapper = Mapper<PartnerApplicationsMapper>().mapArray(JSONObject: response["data"])
        {
            let metadata = MappingUtils.metadataFromResponse(response)
            let dataMapper = MappingUtils.dataIncludeMapperFromResponse(response, metadata: metadata)
            let partnerApplications = partnerApplicationsMapper.map({ PartnerApplication(mapper: $0, dataMapper: dataMapper, metadata: metadata)})
            
            executeOnMainQueue { self.completion?(partnerApplications, ErrorTransformer.errorFromResponse(response, error: error)) }
        }
        else
        {
            executeOnMainQueue { self.completion?(nil, ErrorTransformer.errorFromResponse(response, error: error)) }
        }
    }
}
