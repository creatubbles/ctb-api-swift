//
//  UsersQueueBatchFetcher.swift
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
//

class UsersQueueBatchFetcher: Cancelable
{
    private let pageSize = 20
    private let requestSender: RequestSender
    
    private let userId: String?
    private let query: String?

    private let scope: CreatorsAndManagersScopeElement
    private let completion: UsersBatchClosure?
    
    private var operationQueue: OperationQueue?
    private var firstRequestHandler: RequestHandler?

    private var objectsByPage: Dictionary<PagingData, Array<User>>
    private var errorsByPage: Dictionary<PagingData, APIClientError>
    
    init(requestSender: RequestSender, userId: String?, query: String?, scope: CreatorsAndManagersScopeElement, completion: UsersBatchClosure?)
    {
        self.requestSender = requestSender
        self.userId = userId
        self.scope = scope
        self.completion = completion
        self.query = query
        
        self.objectsByPage = Dictionary<PagingData, Array<User>>()
        self.errorsByPage = Dictionary<PagingData, APIClientError>()
    }
    
    func cancel()
    {
        operationQueue?.cancelAllOperations()
        firstRequestHandler?.cancel()
    }
    
    func fetch() -> RequestHandler
    {
        guard operationQueue == nil
            else
        {
            assert(false) //Fetch should be called only once
            return RequestHandler(object: self)
        }        
        
        let request = CreatorsAndManagersRequest(userId: userId, query: query, page: 1, perPage: pageSize, scope: scope)
        let handler = CreatorsAndManagersResponseHandler()
        {
            [weak self](users, pagingInfo, error) -> (Void) in
            guard let strongSelf = self
                else { return }
            
            if let users = users,
               let pagingInfo = pagingInfo
            {
                strongSelf.objectsByPage[PagingData(page: 1, pageSize: strongSelf.pageSize)] = users
                strongSelf.prepareBlockOperations(pagingInfo: pagingInfo)
            }
            else
            {
                strongSelf.completion?(nil, error)
            }
        }
        
        firstRequestHandler = requestSender.send(request, withResponseHandler: handler)
        return RequestHandler(object: self)
    }
    
    private func prepareBlockOperations(pagingInfo: PagingInfo)
    {
        operationQueue = OperationQueue()
        operationQueue!.maxConcurrentOperationCount = 4
        
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
        
        if pagingInfo.totalPages > 1
        {
            for page in 2...pagingInfo.totalPages
            {
                let pagingData = PagingData(page: page, pageSize: pageSize)
                let operation = UsersBatchFetchOperation(requestSender: requestSender, userId: userId, query: query, scope: scope, pagingData: pagingData)
                {
                    [weak self](operation, error) in
                    guard let strongSelf = self,
                          let operation = operation as? UsersBatchFetchOperation
                    else { return }
                    
                    if let users = operation.users
                    {
                        strongSelf.objectsByPage[operation.pagingData] = users
                    }
                    if let error = error as? APIClientError
                    {
                        strongSelf.errorsByPage[operation.pagingData] = error
                    }
                }
                finishOperation.addDependency(operation)
                operationQueue!.addOperation(operation)
            }
        }
        
        operationQueue!.addOperation(finishOperation)
    }

}
