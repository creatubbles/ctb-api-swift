//
//  NewGalleryResponseHandler.swift
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

class NewGalleryResponseHandler: ResponseHandler
{
    private let completion: GalleryClosure?
    init(completion: GalleryClosure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(response: Dictionary<String, AnyObject>?, error: ErrorType?)
    {
        if let response = response,
           let mapper = Mapper<GalleryMapper>().map(response["data"])
        {
            let metadataMapper = Mapper<MetadataMapper>().map(response["meta"])
            let metadata: Metadata? = metadataMapper != nil ? Metadata(mapper: metadataMapper!) : nil
            
            let includedResponse = response["included"] as? Array<Dictionary<String, AnyObject>>
            let dataMapper: DataIncludeMapper? = includedResponse == nil ? nil : DataIncludeMapper(includeResponse: includedResponse!, metadata: metadata)
            
            let gallery = Gallery(mapper: mapper, dataMapper: dataMapper, metadata: metadata)
            completion?(gallery, ErrorTransformer.errorFromResponse(response, error: ErrorTransformer.errorFromResponse(response, error: error)))
        }
        else
        {
            completion?(nil, ErrorTransformer.errorFromResponse(response, error: ErrorTransformer.errorFromResponse(response, error: error)))
        }
    }
}