//
//  MyGalleriesQueueBatchFetcher.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2017 Creatubbles Pte. Ltd.
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

class MyGalleriesQueueBatchFetcher: Cancelable {
    private let pageSize = 20
    private let requestSender: RequestSender

    private let filter: GalleriesRequestFilter?
    private let completion: GalleriesBatchClosure?

    private var operationQueue: OperationQueue?
    private var firstRequestHandler: RequestHandler?

    private var objectsByPage: Dictionary<PagingData, Array<Gallery>>
    private var errorsByPage: Dictionary<PagingData, APIClientError>

    init(requestSender: RequestSender, filter: GalleriesRequestFilter?, completion: GalleriesBatchClosure?) {
        self.requestSender = requestSender
        self.filter = filter

        self.completion = completion
        self.objectsByPage = Dictionary<PagingData, Array<Gallery>>()
        self.errorsByPage = Dictionary<PagingData, APIClientError>()
    }

    func cancel() {
        operationQueue?.cancelAllOperations()
        firstRequestHandler?.cancel()
    }

    func fetch() -> RequestHandler {
        guard operationQueue == nil
            else {
            assert(false) //Fetch should be called only once
            return RequestHandler(object: self)
        }

        let request = MyGalleriesRequest(page: 1, perPage: pageSize, filter: filter)
        let handler = GalleriesResponseHandler {
            [weak self](galleries, pagingInfo, error) -> (Void) in
            guard let strongSelf = self
                else { return }

            if let galleries = galleries,
               let pagingInfo = pagingInfo {
                strongSelf.objectsByPage[PagingData(page: 1, pageSize: strongSelf.pageSize)] = galleries
                strongSelf.prepareBlockOperations(pagingInfo: pagingInfo)
            } else {
                strongSelf.completion?(nil, error)
            }
        }

        firstRequestHandler = requestSender.send(request, withResponseHandler: handler)
        return RequestHandler(object: self)
    }

    private func prepareBlockOperations(pagingInfo: PagingInfo) {
        operationQueue = OperationQueue()
        operationQueue!.maxConcurrentOperationCount = 4

        let finishOperation = BlockOperation()
        finishOperation.addExecutionBlock {
            [unowned finishOperation, weak self] in
            
            guard let strongSelf = self else  { return }
            if finishOperation.isCancelled {
                strongSelf.completion?(nil, APIClientError.genericError(code: APIClientError.OperationCancelledCode))
                return
            }
            
            DispatchQueue.main.async {
                [weak self] in
                
                guard let strongSelf = self else  { return }
                let objects = strongSelf.objectsByPage.sorted(by: { $0.key.page > $1.key.page }).flatMap({ $0.value })
                let error = strongSelf.errorsByPage.values.first
                
                strongSelf.completion?(objects, error)
            }
        }

        if pagingInfo.totalPages > 1 {
            for page in 2...pagingInfo.totalPages {
                let pagingData = PagingData(page: page, pageSize: pageSize)
                let operation = MyGalleriesBatchFetchOperation(requestSender: requestSender, filter: filter, pagingData: pagingData) {
                    [weak self](operation, error) in
                    guard let strongSelf = self,
                          let operation = operation as? MyGalleriesBatchFetchOperation
                    else { return }

                    if let galleries = operation.galleries {
                        strongSelf.objectsByPage[operation.pagingData] = galleries
                    }
                    if let error = error as? APIClientError {
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
