//
//  GalleriesBatchFetcher.swift
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

class GalleriesBatchFetcher: BatchFetcher
{
    fileprivate var userId: String?
    fileprivate var sort: SortOrder?
    fileprivate var allGalleries = Array<Gallery>()
    
    fileprivate var currentRequest: GalleriesRequest
    {
        return GalleriesRequest(page: page, perPage: perPage, sort: sort, userId: userId)
    }
    
    fileprivate func responseHandler(_ completion: GalleriesBatchClosure?) -> GalleriesResponseHandler
    {
        return GalleriesResponseHandler()
        {
            (galleries, pInfo, error) -> (Void) in
            if let error = error
            {
                completion?(self.allGalleries, error)
            }
            else
            {
                if let galleries = galleries
                {
                    self.allGalleries.append(contentsOf: galleries)
                }
                if let pInfo = pInfo
                {
                    if(pInfo.totalPages > self.page && self.page < self.maxPageCount)
                    {
                        self.page += 1
                        _ = self.requestSender.send(self.currentRequest, withResponseHandler: self.responseHandler(completion))
                    }
                    else
                    {
                        completion?(self.allGalleries, error)
                    }
                }
            }
        }
    }
    
    func fetch(_ userId: String?, sort:SortOrder?, completion: GalleriesBatchClosure?) -> RequestHandler
    {
        self.userId = userId
        self.sort = sort
        return requestSender.send(currentRequest, withResponseHandler: responseHandler(completion))
    }
}
