//
//  CreationsBatchFetcher.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 26.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

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
