//
//  ConcurrentOperation.swift
//  Creatubbles Explorer
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

import UIKit

class ConcurrentOperation: Operation
{
    typealias OperationCompleteClosure = (_ operation: Operation?, _ error: Error?) -> ()
    fileprivate let complete: OperationCompleteClosure?

    init(complete: OperationCompleteClosure?)
    {
        self.complete = complete
        super.init()
    }

    // MARK: - Types
    enum State
    {
        case ready, executing, finished
        func keyPath() -> String
        {
            switch self
            {
            case .ready:
                return "isReady"
            case .executing:
                return "isExecuting"
            case .finished:
                return "isFinished"
            }
        }
    }

    // MARK: - Properties
    var state = State.ready
    {
        willSet
        {
            self.willChangeValue(forKey: newValue.keyPath())
            self.willChangeValue(forKey: state.keyPath())
        }

        didSet
        {
            self.didChangeValue(forKey: oldValue.keyPath())
            self.didChangeValue(forKey: state.keyPath())
        }
    }

    // MARK: - NSOperation
    override var isReady: Bool { return super.isReady && self.state == .ready }
    override var isExecuting: Bool { return self.state == .executing }
    override var isFinished: Bool { return self.state == .finished }
    override var isAsynchronous: Bool { return true }

    // MARK: - Methods
    override func start()
    {
        guard Thread.isMainThread else
        {
            self.performSelector(onMainThread: #selector(Operation.start), with: nil, waitUntilDone: false)
            return
        }

        if self.isCancelled
        {
            self.finish()
        }
        else
        {
            self.state = .executing
            
            DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
                self.main()
            }
        }
    }

    final func finish(_ error: Error? = nil)
    {
        DispatchQueue.main.async { [weak self] in

            if let strongSelf = self
            {
                strongSelf.state = .finished
                strongSelf.complete?(strongSelf, error)
            }
        }
    }
}
