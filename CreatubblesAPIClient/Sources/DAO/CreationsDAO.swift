//
//  CreationsDAO.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 18.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

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
