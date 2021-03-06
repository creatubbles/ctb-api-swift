//
//  CreationUploadSessionOperation.swift
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

class CreationUploadSessionOperation: ConcurrentOperation {
    fileprivate let session: CreationUploadSession
    fileprivate let completion: CreationClosure?
    
    init(session: CreationUploadSession, completion: CreationClosure?) {
        self.session = session
        self.completion = completion
        
        super.init(complete: nil)
    }
    
    override func main() {
        // completion is called in the cancel() method so we just return here
        guard isCancelled == false else { return }
        
        session.start { [weak self] (creation, error) -> (Void) in
            self?.finish(error)
            
            self?.completion?(creation, error)
        }
    }
    
    override func cancel() {
        session.cancel()
        
        let error = APIClientError.genericUploadCancelledError
        completion?(nil, error)
        
        super.cancel()
    }
}
