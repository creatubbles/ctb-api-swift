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
    fileprivate let requestSender: RequestSender
    
    init(requestSender: RequestSender)
    {
        self.requestSender = requestSender
    }
    
    func getCreation(creationIdentifier creationId: String, completion: CreationClosure?) -> RequestHandler
    {
        let request = FetchCreationsRequest(creationId: creationId)
        let handler = FetchCreationsResponseHandler
        {
            (creations, pageInfo, error) -> (Void) in
            completion?(creations?.first, error)
        }
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func reportCreation(creationIdentifier creationId: String, message: String, completion: ErrorClosure?) -> RequestHandler
    {
        let request = ReportCreationRequest(creationId: creationId, message: message)
        let handler = ReportCreationResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getRecomendedCreationsByUser(userIdentifier userId: String, pagingData: PagingData?, completon: CreationsClosure?) -> RequestHandler
    {
        let request = FetchCreationsRequest(page: pagingData?.page, perPage: pagingData?.pageSize, recommendedUserId: userId)
        let handler = FetchCreationsResponseHandler(completion: completon)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getRecomendedCreationsByCreation(creationIdentifier creationId: String, pagingData: PagingData?, completon: CreationsClosure?) -> RequestHandler
    {
        let request = FetchCreationsRequest(page: pagingData?.page, perPage: pagingData?.pageSize, recommendedCreationId: creationId)
        let handler = FetchCreationsResponseHandler(completion: completon)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getCreations(galleryIdentifier galleryId: String?, userId: String?, keyword: String?, pagingData: PagingData?, sortOrder: SortOrder?, partnerApplicationId: String?, onlyPublic: Bool, completion: CreationsClosure?) -> RequestHandler
    {
        let request = FetchCreationsRequest(page: pagingData?.page, perPage: pagingData?.pageSize, galleryId: galleryId, userId: userId, sort: sortOrder, keyword: keyword, partnerApplicationId: partnerApplicationId, onlyPublic: onlyPublic)
        let handler = FetchCreationsResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func editCreation(creationIdentifier creationId: String, data: EditCreationData, completion: ErrorClosure?) -> RequestHandler
    {
        let request = EditCreationRequest(identifier: creationId, data: data)
        let handler = EditCreationResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func removeCreation(creationIdentifier creationId: String, completion: ErrorClosure?) -> RequestHandler
    {

        let request = RemoveCreationRequest(creationId: creationId)
        let handler = RemoveCreationResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getToybooCreation(creationIdentifier creationId: String, completion: ToybooCreationClosure?) -> RequestHandler
    {
        let request = FetchToybooCreationRequest(creationId: creationId)
        let handler = FetchToybooCreationResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    //MARK: BatchMode
    func getCreationsInBatchMode(galleryIdentifier galleryId: String?, userId: String?, keyword: String?, sortOrder: SortOrder?, partnerApplicationId: String?, onlyPublic: Bool, completion: CreationsBatchClosure?) -> RequestHandler
    {        
        let fetcher =  CreationsQueueBatchFetcher(requestSender: requestSender,userId: userId, galleryId: galleryId, keyword: keyword, partnerApplicationId: partnerApplicationId, sort: sortOrder, onlyPublic: onlyPublic, completion: completion)
        return fetcher.fetch()
    }
}
