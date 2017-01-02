//
//  GallerySubmitOperation.swift
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

import UIKit

class GallerySubmitOperation: ConcurrentOperation
{
    private let requestSender: RequestSender
    private let galleryId: String
    private let creationId: String
    private var requestHandler: RequestHandler?
    
    init(requestSender: RequestSender, galleryId: String, creationId: String, complete: OperationCompleteClosure?)
    {
        self.requestSender = requestSender
        self.creationId = creationId
        self.galleryId = galleryId
        
        super.init(complete: complete)
    }
    
    override func main()
    {
        guard isCancelled == false else { return }
        
        let request = GallerySubmissionRequest(galleryId: galleryId, creationId: creationId)
        let handler = GallerySubmissionResponseHandler()
        {
            [weak self](error) -> (Void) in
            self?.finish(error)
        }
        
        requestHandler = requestSender.send(request, withResponseHandler: handler)
    }
    
    override func cancel()
    {
        requestHandler?.cancel()
        super.cancel()
    }

}
