//
//  PartnerApplicationsResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 02.08.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class PartnerApplicationResponseHandler: ResponseHandler
{
    fileprivate let completion: PartnerApplicationClosure?
    init(completion: PartnerApplicationClosure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(_ response: Dictionary<String, AnyObject>?, error: Error?)
    {
        if  let response = response,
            let partnerApplicationsMapper = Mapper<PartnerApplicationsMapper>().map(response["data"])
        {
            let metadata = MappingUtils.metadataFromResponse(response)
            let dataMapper = MappingUtils.dataIncludeMapperFromResponse(response, metadata: metadata)
            let partnerApplication = PartnerApplication(mapper: partnerApplicationsMapper, dataMapper: dataMapper, metadata: metadata)
            
            executeOnMainQueue { self.completion?(partnerApplication, ErrorTransformer.errorFromResponse(response, error: ErrorTransformer.errorFromResponse(response, error: error))) }
        }
        else
        {
            executeOnMainQueue { self.completion?(nil, ErrorTransformer.errorFromResponse(response, error: error)) }
        }
    }
}
