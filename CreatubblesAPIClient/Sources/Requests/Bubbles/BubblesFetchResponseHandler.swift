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
            var bubbles = Array<Bubble>()
            for mapper in mappers
            {
                bubbles.append(Bubble(mapper: mapper))
            }
            
            completion?(bubbles, ErrorTransformer.errorFromResponse(response, error: error))
        }
        else
        {
            completion?(nil, ErrorTransformer.errorFromResponse(response, error: error))
        }
    }
}
