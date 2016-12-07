//
//  CreationsBatchFetchOperation.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 07.12.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class CreationsBatchFetchOperation: ConcurrentOperation
{
    private let requestSender: RequestSender
    
    private let userId: String?
    private let galleryId: String?
    private let keyword: String?
    private let partnerApplicationId: String?
    private let sort:SortOrder?
    private let onlyPublic: Bool
    
    let pagingData: PagingData
    private(set) var creations: Array<Creation>?
    
    init(requestSender: RequestSender, userId: String?, galleryId: String?, keyword: String?, partnerApplicationId: String?, sort:SortOrder?, onlyPublic: Bool, pagingData: PagingData, complete: OperationCompleteClosure?)
    {
        self.requestSender = requestSender
        self.userId = userId
        self.galleryId = galleryId
        self.keyword = keyword
        self.partnerApplicationId = partnerApplicationId
        self.sort = sort
        self.onlyPublic = onlyPublic
        self.pagingData = pagingData
        
        super.init(complete: complete)
    }
    
    override func main()
    {
        let request =  FetchCreationsRequest(page: pagingData.page, perPage: pagingData.pageSize, galleryId: galleryId, userId: userId, sort: sort, keyword: keyword, partnerApplicationId: partnerApplicationId, onlyPublic: onlyPublic)
        let handler = FetchCreationsResponseHandler()
        {
            [weak self](creations, pagingInfo, error) -> (Void) in
            self?.creations = creations
            self?.finish(error)
        }
        requestSender.send(request, withResponseHandler: handler)
    }
}
