//
//  CreationUploadSessionOperation.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 05.12.2017.
//  Copyright © 2017 Nomtek. All rights reserved.
//

class CreationUploadSessionOperation: ConcurrentOperation {
    fileprivate let session: CreationUploadSession
    fileprivate let completion: CreationClosure?
    
    init(session: CreationUploadSession, completion: CreationClosure?) {
        self.session = session
        self.completion = completion
        
        super.init(complete: nil)
    }
    
    override func main() {
        guard isCancelled == false else { return }
        
        session.start { [weak self] (creation, error) -> (Void) in
            self?.finish(error)
            
            self?.completion?(creation, error)
        }
    }
    
    override func cancel() {
        session.cancel()
        super.cancel()
    }
}
