//
//  GalleriesBatchFetchOperation.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 07.12.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

class GalleriesBatchFetchOperation: ConcurrentOperation
{
    private let requestSender: RequestSender
    
    private let userId: String?
    private let sort:SortOrder?
    
    
    let pagingData: PagingData
    private(set) var galleries: Array<Gallery>?
    private var request: GalleriesRequest?
    
    init(requestSender: RequestSender, userId: String?, sort:SortOrder?, pagingData: PagingData, complete: OperationCompleteClosure?)
    {
        self.requestSender = requestSender
        self.userId = userId
        self.sort = sort
        self.pagingData = pagingData
        
        super.init(complete: complete)
    }
    
    override func main()
    {
        guard isCancelled == false else { return }

        request =  GalleriesRequest(page: pagingData.page, perPage: pagingData.pageSize, sort: sort, userId: userId)
        let handler = GalleriesResponseHandler()
        {
            [weak self](galleries, pagingInfo, error) -> (Void) in
            self?.galleries = galleries
            self?.finish(error)
        }
        requestSender.send(request!, withResponseHandler: handler)
    }
    
    override func cancel()
    {
        request?.cancel()
        super.cancel()
    }
}
