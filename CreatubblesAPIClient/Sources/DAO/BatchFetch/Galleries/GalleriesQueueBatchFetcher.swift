//
//  GalleriesQueueBatchFetcher.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 07.12.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class GalleriesQueueBatchFetcher
{
    private let pageSize = 20
    private let requestSender: RequestSender
    
    private let userId: String?
    private let sort:SortOrder?
    private let completion: GalleriesBatchClosure?
    
    private var operationQueue: OperationQueue!
    private var objectsByPage: Dictionary<PagingData, Array<Gallery>>
    private var errorsByPage: Dictionary<PagingData, APIClientError>
    
    init(requestSender: RequestSender, userId: String?, sort:SortOrder?, completion: GalleriesBatchClosure?)
    {
        self.requestSender = requestSender
        self.userId = userId
        self.sort = sort
        self.completion = completion
        self.objectsByPage = Dictionary<PagingData, Array<Gallery>>()
        self.errorsByPage = Dictionary<PagingData, APIClientError>()
    }
    
    func fetch()
    {
        guard operationQueue == nil
            else
        {
            assert(false) //Fetch should be called only once
            return
        }
        
        let request =  GalleriesRequest(page: 1, perPage: pageSize, sort: sort, userId: userId)
        let handler = GalleriesResponseHandler()
        {
            [weak self](galleries, pagingInfo, error) -> (Void) in
            guard let strongSelf = self
                else { return }
            
            if let galleries = galleries,
               let pagingInfo = pagingInfo
            {
                strongSelf.objectsByPage[PagingData(page: 1, pageSize: strongSelf.pageSize)] = galleries
                strongSelf.prepareBlockOperations(pagingInfo: pagingInfo)
            }
            else
            {
                strongSelf.completion?(nil, error)
            }
        }
        requestSender.send(request, withResponseHandler: handler)
    }
    
    private func prepareBlockOperations(pagingInfo: PagingInfo)
    {
        operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 4
        
        let finishOperation = BlockOperation()
        finishOperation.addExecutionBlock()
        {
            [unowned finishOperation, weak self] in
            guard let strongSelf = self, !finishOperation.isCancelled else { return }
            let objects = strongSelf.objectsByPage.sorted(by: { $0.key.page > $1.key.page}).flatMap({ $0.value })
            let error = strongSelf.errorsByPage.values.first
            DispatchQueue.main.async
            {
                [weak self] in
                self?.completion?(objects, error)
            }
        }
        
        for page in 2...pagingInfo.totalPages
        {
            let pagingData = PagingData(page: page, pageSize: pageSize)
            let operation = GalleriesBatchFetchOperation(requestSender: requestSender, userId: userId, sort: sort, pagingData: pagingData)
            {
                [weak self](operation, error) in
                guard let strongSelf = self,
                      let operation = operation as? GalleriesBatchFetchOperation
                else { return }
                
                if let galleries = operation.galleries
                {
                    strongSelf.objectsByPage[operation.pagingData] = galleries
                }
                if let error = error as? APIClientError
                {
                    strongSelf.errorsByPage[operation.pagingData] = error
                }
            }
            finishOperation.addDependency(operation)
            operationQueue.addOperation(operation)
        }
        
        operationQueue.addOperation(finishOperation)
    }

}
