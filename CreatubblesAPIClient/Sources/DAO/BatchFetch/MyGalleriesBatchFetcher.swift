//
//  MyGalleriesBatchFetcher.swift
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

class MyGalleriesBatchFetcher: BatchFetcher {
    fileprivate var filter: MyGalleriesRequestFilter = .none
    fileprivate var galleries = Array<Gallery>()
    
    fileprivate var currentRequest: MyGalleriesRequest {
        return MyGalleriesRequest(page: page, perPage: perPage, filter: filter)
    }
    
    fileprivate func responseHandler(_ completion: GalleriesBatchClosure?) -> GalleriesResponseHandler {
        return GalleriesResponseHandler() { (galleries, pagingInfo, error) -> (Void) in
            if let error = error {
                completion?(self.galleries, error)
            } else {
                if let galleries = galleries {
                    self.galleries.append(contentsOf: galleries)
                }
                
                if let pagingInfo = pagingInfo {
                    if(pagingInfo.totalPages > self.page && self.page < self.maxPageCount) {
                        self.page += 1
                       _ = self.requestSender.send(self.currentRequest, withResponseHandler: self.responseHandler(completion))
                    } else {
                        completion?(self.galleries, error)
                    }
                }
            }
        }
    }
    
    func fetch(_ filter: MyGalleriesRequestFilter, completion: GalleriesBatchClosure?) -> RequestHandler {
        self.filter = filter
        return requestSender.send(currentRequest, withResponseHandler: responseHandler(completion))
    }
}
