//
//  BatchFetchHandler.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 07.12.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class BatchFetchHandler: Cancelable
{
    private let operationQueue: OperationQueue
    private let firstCallRequestHandler: RequestHandler
    
    init(operationQueue: OperationQueue, firstCallRequestHandler: RequestHandler)
    {
        self.operationQueue = operationQueue
        self.firstCallRequestHandler = firstCallRequestHandler
    }
    
    func cancel()
    {
        firstCallRequestHandler.cancel()
        operationQueue.cancelAllOperations()
    }
}
