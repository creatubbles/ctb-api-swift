//
//  CreationsQueueBatchFetcher.swift
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


class CreationsQueueBatchFetcher
{
    private let pageSize = 20
    private let requestSender: RequestSender
    
    private let userId: String?
    private let galleryId: String?
    private let keyword: String?
    private let partnerApplicationId: String?
    private let sort:SortOrder?
    private let onlyPublic: Bool
    private let completion: CreationsBatchClosure?
    
    private var operationQueue: OperationQueue!
    private var creationsByPage: Dictionary<PagingData, Array<Creation>>
    private var errorsByPage: Dictionary<PagingData, APIClientError>
    
    init(requestSender: RequestSender, userId: String?, galleryId: String?, keyword: String?, partnerApplicationId: String?, sort:SortOrder?, onlyPublic: Bool, completion: CreationsBatchClosure?)
    {
        self.requestSender = requestSender
        self.userId = userId
        self.galleryId = galleryId
        self.keyword = keyword
        self.partnerApplicationId = partnerApplicationId
        self.sort = sort
        self.onlyPublic = onlyPublic
        self.completion = completion
        self.creationsByPage = Dictionary<PagingData, Array<Creation>>()
        self.errorsByPage = Dictionary<PagingData, APIClientError>()
    }
    
    func fetch() -> RequestHandler
    {
        guard operationQueue == nil
        else
        {
            assert(false) //Fetch should be called only once
            return RequestHandler(object: BatchFetchDummyRequestHandler())
        }
        
        operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 4
        
        let request =  FetchCreationsRequest(page: 1, perPage: pageSize, galleryId: galleryId, userId: userId, sort: sort, keyword: keyword, partnerApplicationId: partnerApplicationId, onlyPublic: onlyPublic)
        let handler = FetchCreationsResponseHandler
        {
            [weak self](creations, pagingInfo, error) -> (Void) in
            guard let strongSelf = self
            else { return }
            
            if let creations = creations,
               let pagingInfo = pagingInfo
            {
                strongSelf.creationsByPage[PagingData(page: 1, pageSize: strongSelf.pageSize)] = creations
                strongSelf.prepareBlockOperations(pagingInfo: pagingInfo)
            }
            else
            {
                strongSelf.completion?(nil, error)
            }
        }
    
        let requestHandler = requestSender.send(request, withResponseHandler: handler)
        return RequestHandler(object: BatchFetchHandler(operationQueue: operationQueue, firstCallRequestHandler: requestHandler))
    }
    
    private func prepareBlockOperations(pagingInfo: PagingInfo)
    {
        let finishOperation = BlockOperation()
        finishOperation.addExecutionBlock()
        {
            [unowned finishOperation, weak self] in
            guard let strongSelf = self, !finishOperation.isCancelled else { return }
            let creations = strongSelf.creationsByPage.sorted(by: { $0.key.page > $1.key.page}).flatMap({ $0.value })
            let error = strongSelf.errorsByPage.values.first
            DispatchQueue.main.async
            {
                [weak self] in
                self?.completion?(creations, error)
            }
        }
        
        if pagingInfo.totalPages > 1
        {
            for page in 2...pagingInfo.totalPages
            {
                let pagingData = PagingData(page: page, pageSize: pageSize)
                let operation = CreationsBatchFetchOperation(requestSender: requestSender, userId: userId, galleryId: galleryId, keyword: keyword, partnerApplicationId: partnerApplicationId, sort: sort, onlyPublic: onlyPublic, pagingData: pagingData)
                {
                    [weak self](operation, error) in
                    guard let strongSelf = self,
                          let operation = operation as? CreationsBatchFetchOperation
                    else { return }
                    if let creations = operation.creations
                    {
                        strongSelf.creationsByPage[operation.pagingData] = creations
                    }
                    if let error = error as? APIClientError
                    {
                        strongSelf.errorsByPage[operation.pagingData] = error
                    }
                }
                finishOperation.addDependency(operation)
                operationQueue.addOperation(operation)
            }
        }
        
        operationQueue.addOperation(finishOperation)
    }
}
