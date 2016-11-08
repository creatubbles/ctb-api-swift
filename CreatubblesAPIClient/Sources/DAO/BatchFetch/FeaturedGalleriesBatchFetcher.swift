//
//  FeaturedGalleriesBatchFetcher.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 06.09.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class FeaturedGalleriesBatchFetcher: BatchFetcher {
    fileprivate var galleries = Array<Gallery>()
    
    fileprivate var currentRequest: FeaturedGalleriesRequest {
        return FeaturedGalleriesRequest(page: page, perPage: perPage)
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
    
    func fetch(_ completion: GalleriesBatchClosure?) -> RequestHandler {
        return requestSender.send(currentRequest, withResponseHandler: responseHandler(completion))
    }
}
