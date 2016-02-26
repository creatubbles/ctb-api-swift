//
//  GalleriesBatchFetcher.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 26.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class GalleriesBatchFetcher: BatchFetcher
{
    private var userId: String?
    private var sort: SortOrder?
    private var allGalleries = Array<Gallery>()
    
    private var currentRequest: GalleriesRequest
    {
        return GalleriesRequest(page: page, perPage: perPage, sort: sort, userId: userId)
    }
    
    private func responseHandler(completion: GalleriesBatchClousure?) -> GalleriesResponseHandler
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
                    self.allGalleries.appendContentsOf(galleries)
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
                        completion?(self.allGalleries, error)
                    }
                }
            }
        }
    }
    
    func fetch(userId: String?, sort:SortOrder?, completion: GalleriesBatchClousure?)
    {
        self.userId = userId
        self.sort = sort
        requestSender.send(currentRequest, withResponseHandler: responseHandler(completion))
    }
}
