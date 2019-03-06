//
//  HubSubmitter.swift
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

class HubSubmitter: Cancelable {
    private let requestSender: RequestSender
    private let creationId: String
    private let hubIdentifiers: Array<String>
    private let completion: ErrorClosure?
    
    private var operationQueue: OperationQueue?
    private var errors: Array<APIClientError>
    
    init(requestSender: RequestSender, creationId: String, hubIdentifiers: Array<String>, completion: ErrorClosure?) {
        self.requestSender = requestSender
        self.creationId = creationId
        self.hubIdentifiers = hubIdentifiers
        self.completion = completion
        self.errors = Array<APIClientError>()
    }
    
    func cancel() {
        operationQueue?.cancelAllOperations()
    }
    
    func submit() -> RequestHandler {
        guard operationQueue == nil
            else {
                assert(false) //Fetch should be called only once
                return RequestHandler(object: self)
        }
        
        operationQueue = OperationQueue()
        operationQueue!.maxConcurrentOperationCount = 4
        
        let finishOperation = BlockOperation()
        finishOperation.addExecutionBlock {
            [unowned finishOperation, weak self] in
            guard let strongSelf = self, !finishOperation.isCancelled else { return }
            let error = strongSelf.errors.first
            
            DispatchQueue.main.async {
                [weak self] in
                self?.completion?(error)
            }
        }
        
        hubIdentifiers.forEach {
            (hubId) in
            let operation = HubSubmitOperation(requestSender: requestSender, hubId: hubId, creationId: creationId) {
                [weak self](operation, error) in
                guard operation is HubSubmitOperation,
                    let error = error as? APIClientError,
                    let strongSelf = self
                    else { return }
                strongSelf.errors.append(error)
            }
            
            finishOperation.addDependency(operation)
            operationQueue!.addOperation(operation)
        }
        operationQueue!.addOperation(finishOperation)
        
        return RequestHandler(object: self)
    }
}
