//
//  ContentResponseHandler.swift
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
//


import UIKit
import ObjectMapper

class ContentResponseHandler: ResponseHandler
{
    fileprivate let completion: ContentEntryClosure?
    fileprivate let validator: Validatable = ContentDataFilter()
    
    init(completion: ContentEntryClosure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(_ response: Dictionary<String, AnyObject>?, error: Error?)
    {
        var validEntries: [ContentEntry] = []
        var invalidEntries: [ContentEntry] = []
        
        if  let response = response,
            let mappers = Mapper<ContentEntryMapper>().mapArray(JSONObject: response["data"])
        {
            let metadata = MappingUtils.metadataFromResponse(response)
            let pageInfo = MappingUtils.pagingInfoFromResponse(response)
            let dataMapper = MappingUtils.dataIncludeMapperFromResponse(response, metadata: metadata)
            
            mappers.forEach({ (mapper) in
                let contentEntry = ContentEntry(mapper: mapper, dataMapper: dataMapper)
                
                validator.isValid(contentEntry) ? validEntries.append(contentEntry) : invalidEntries.append(contentEntry)
            })
            
            let responseData = ResponseData(objects: validEntries, rejectedObjects: invalidEntries, pagingInfo: pageInfo, error: ErrorTransformer.errorFromResponse(response ,error: error))
            executeOnMainQueue { self.completion?(responseData) }
        }
        else
        {
            let responseData = ResponseData(objects: validEntries, rejectedObjects: validEntries, pagingInfo: nil, error: ErrorTransformer.errorFromResponse(response ,error: error))
            executeOnMainQueue { self.completion?(responseData) }
        }
    }
}
