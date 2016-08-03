//
//  PartnerApplicationsResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 02.08.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class PartnerApplicationsResponseHandler: ResponseHandler
{
    private let completion: PartnerApplicationsClosure?
    init(completion: PartnerApplicationsClosure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(response: Dictionary<String, AnyObject>?, error: ErrorType?)
    {
        if  let response = response,
            let partnerApplicationsMapper = Mapper<PartnerApplicationsMapper>().mapArray(response["data"])
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
