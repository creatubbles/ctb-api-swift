//
//  FetchCreationsResponseHandler.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2017 Creatubbles Pte. Ltd.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit
import ObjectMapper

class FetchCreationsResponseHandler: ResponseHandler
{
    fileprivate let completion: CreationsClosure?
    
    init(completion: CreationsClosure?)
    {
        self.completion = completion
    }

    override func handleResponse(_ response: Dictionary<String, AnyObject>?, error: Error?)
    {
        if  let response = response,
            let mappers = Mapper<CreationMapper>().mapArray(JSONObject: response["data"])
        {
            let metadata = MappingUtils.metadataFromResponse(response)
            let pageInfo = MappingUtils.pagingInfoFromResponse(response)
            let dataMapper = MappingUtils.dataIncludeMapperFromResponse(response, metadata: metadata)
            let creations = mappers.map({ Creation(mapper: $0, dataMapper: dataMapper, metadata: metadata)})
            
            executeOnMainQueue { self.completion?(creations,pageInfo, ErrorTransformer.errorFromResponse(response, error: error)) }
        }
        else if let response = response,
                let mapper = Mapper<CreationMapper>().map(JSON: response["data"] as! [String : Any])
        {
            let metadata = MappingUtils.metadataFromResponse(response)
            let dataMapper = MappingUtils.dataIncludeMapperFromResponse(response, metadata: metadata)
            let creation = Creation(mapper: mapper, dataMapper: dataMapper, metadata: metadata)
            
            executeOnMainQueue { self.completion?([creation], nil, ErrorTransformer.errorFromResponse(response, error: error)) }
        }
        else
        {
            executeOnMainQueue { self.completion?(nil, nil, ErrorTransformer.errorFromResponse(response, error: error)) }
        }
    }

}
