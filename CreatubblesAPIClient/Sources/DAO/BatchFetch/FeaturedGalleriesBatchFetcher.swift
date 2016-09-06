//
//  FeaturedGalleriesBatchFetcher.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 06.09.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class FeaturedGalleriesBatchFetcher: BatchFetcher {
    private var galleries = Array<Gallery>()
    
    private var currentRequest: FeaturedGalleriesRequest {
        return FeaturedGalleriesRequest(page: page, perPage: perPage)
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
    
    func fetch(completion: GalleriesBatchClosure?) -> RequestHandler {
        return requestSender.send(currentRequest, withResponseHandler: responseHandler(completion))
    }
}
