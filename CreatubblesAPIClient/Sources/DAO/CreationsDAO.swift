//
//  CreationsDAO.swift
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

class CreationsDAO
{
    private let requestSender: RequestSender
    
    init(requestSender: RequestSender)
    {
        self.requestSender = requestSender
    }
    
    func getCreation(creationId: String, completion: CreationClousure?)
    {
        let request = FetchCreationsRequest(creationId: creationId)
        let handler = FetchCreationsResponseHandler
        {
            (creations, pageInfo, error) -> (Void) in
            completion?(creations?.first, error)
        }
        requestSender.send(request, withResponseHandler: handler)
    }
    
    func getCreations(galleryId: String?, userId: String?, keyword: String? ,pagingData: PagingData?, sortOrder: SortOrder?,completion: CreationsClousure?)
    {
        let request = FetchCreationsRequest(page: pagingData?.page, perPage: pagingData?.pageSize, galleryId: galleryId, userId: userId, sort: sortOrder, keyword: keyword)
        let handler = FetchCreationsResponseHandler(completion: completion)
        requestSender.send(request, withResponseHandler: handler)
    }
    
    func getCreations(galleryId: String?, userId: String?, keyword: String?, sortOrder: SortOrder?, completion: CreationsBatchClousure?)
    {
        let fetcher = CreationsBatchFetcher(requestSender: requestSender)
        fetcher.fetch(userId, galleryId: galleryId, keyword: keyword, sort: sortOrder, completion: completion)
    }

}
