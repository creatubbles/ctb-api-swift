//
//  FetchCreationsResponseHandler.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2016 Creatubbles Pte. Ltd.
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
    private let completion: CreationsClousure?
    
    init(completion: CreationsClousure?)
    {
        self.completion = completion
    }

    override func handleResponse(response: Dictionary<String, AnyObject>?, error: ErrorType?)
    {        
        if  let response = response,
            let builders = Mapper<CreationModelBuilder>().mapArray(response["data"])
        {
            var creations = Array<Creation>()
            for builder in builders
            {
                creations.append(Creation(builder: builder))
            }
            
            let pageInfoBuilder = Mapper<PagingInfoModelBuilder>().map(response["meta"])!
            let pageInfo = PagingInfo(builder: pageInfoBuilder)
            
            completion?(creations,pageInfo, ErrorTransformer.errorFromResponse(response, error: error))
        }
        else if let response = response,
            let builder = Mapper<CreationModelBuilder>().map(response["data"])
        {
            let creation = Creation(builder: builder)
            completion?([creation], nil, ErrorTransformer.errorFromResponse(response, error: error))
        }
        else
        {
            completion?(nil, nil, ErrorTransformer.errorFromResponse(response, error: error))
        }
    }

}
