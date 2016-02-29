//
//  CreationsBatchFetcher.swift
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

class CreationsBatchFetcher: BatchFetcher
{
    private var userId: String?
    private var galleryId: String?

    private var sort: SortOrder?
    private var keyword: String?
    
    private var allCreations = Array<Creation>()
    
    private var currentRequest: FetchCreationsRequest
    {
        return FetchCreationsRequest(page: page, perPage: perPage, galleryId: galleryId, userId: userId, sort: sort, keyword: keyword)
    }
    
    private func responseHandler(completion: CreationsBatchClousure?) -> FetchCreationsResponseHandler
    {
        return FetchCreationsResponseHandler()
        {
            (creations, pInfo, error) -> (Void) in
            if let error = error
            {
                completion?(self.allCreations, error)
            }
            else
            {
                if let creations = creations
                {
                    self.allCreations.appendContentsOf(creations)
                }
                if let pInfo = pInfo
                {
                    if(pInfo.totalPages > self.page && self.page < self.maxPageCount)
                    {
                        self.page += 1
                        self.requestSender.send(self.currentRequest, withResponseHandler: self.responseHandler(completion))
                    }
                    else
                    {
                        completion?(self.allCreations, error)
                    }
                }
            }
        }
    }
    
    func fetch(userId: String?, galleryId: String?,keyword: String? ,sort:SortOrder?, completion: CreationsBatchClousure?)
    {
        self.userId = userId
        self.sort = sort
        self.keyword = keyword
        self.galleryId = galleryId
        requestSender.send(currentRequest, withResponseHandler: responseHandler(completion))
    }
}
