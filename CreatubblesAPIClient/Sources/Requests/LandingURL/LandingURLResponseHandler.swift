//
//  LandingURLResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 07.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit
import ObjectMapper

class LandingURLResponseHandler: ResponseHandler
{
    private let completion: LandingURLClousure?
    init(completion: LandingURLClousure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(response: Dictionary<String, AnyObject>?, error: ErrorType?)
    {
        if  let response = response,
            let mappers = Mapper<LandingURLMapper>().mapArray(response["data"])
        {
            var landingUrls = Array<LandingURL>()
            for mapper in mappers
            {
                landingUrls.append(LandingURL(mapper: mapper))
            }
            completion?(landingUrls, ErrorTransformer.errorFromResponse(response, error: error))
        }
        else if let response = response,
                let mapper = Mapper<LandingURLMapper>().map(response["data"])
        {
            let landingURL = LandingURL(mapper: mapper)
            completion?([landingURL], ErrorTransformer.errorFromResponse(response, error: error))
        }
        else
        {
            completion?(nil, ErrorTransformer.errorFromResponse(response, error: error))
        }
    }
}
