//
//  CreatorsAndManagersResponseHandler.swift
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

class CreatorsAndManagersResponseHandler: ResponseHandler
{
    private let completion: UsersClosure?
    init(completion: UsersClosure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(response: Dictionary<String, AnyObject>?, error: ErrorType?)
    {
        if  let response = response,
            let usersMapper = Mapper<UserMapper>().mapArray(response["data"])
        {
            let metadata = MappingUtils.metadataFromResponse(response)
            let pageInfo = MappingUtils.pagingInfoFromResponse(response)
            let dataMapper = MappingUtils.dataIncludeMapperFromResponse(response, metadata: metadata)
            let users = usersMapper.map({ User(mapper: $0, dataMapper: dataMapper, metadata: metadata)})
            
            completion?(users, pageInfo, ErrorTransformer.errorFromResponse(response, error: error))
        }
        else
        {
            completion?(nil, nil, ErrorTransformer.errorFromResponse(response, error: error))
        }
    }
}
