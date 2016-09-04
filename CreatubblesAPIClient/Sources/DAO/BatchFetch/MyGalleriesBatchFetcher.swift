//
//  MyGalleriesBatchFetcher.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek  on 04.09.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class MyGalleriesBatchFetcher: BatchFetcher {
    private var filter: MyGalleriesRequestFilter = .None
    private var galleries = Array<Gallery>()
    
    private var currentRequest: MyGalleriesRequest {
        return MyGalleriesRequest(page: page, perPage: perPage, filter: filter)
    }
    
    private func responseHandler(completion: GalleriesBatchClosure?) -> GalleriesResponseHandler {
        return GalleriesResponseHandler() { (galleries, pagingInfo, error) -> (Void) in
            if let error = error {
                completion?(self.galleries, error)
            } else {
                if let galleries = galleries {
                    self.galleries.appendContentsOf(galleries)
                }
                
                if let pagingInfo = pagingInfo {
                    if(pagingInfo.totalPages > self.page && self.page < self.maxPageCount) {
                        self.page += 1
                        self.requestSender.send(self.currentRequest, withResponseHandler: self.responseHandler(completion))
                    } else {
                        completion?(self.galleries, error)
                    }
                }
            }
        }
    }
    
    func fetch(filter: MyGalleriesRequestFilter, completion: GalleriesBatchClosure?) -> RequestHandler {
        self.filter = filter
        return requestSender.send(currentRequest, withResponseHandler: responseHandler(completion))
    }
}