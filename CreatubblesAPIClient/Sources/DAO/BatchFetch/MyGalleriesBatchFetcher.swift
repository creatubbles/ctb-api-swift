//
//  MyGalleriesBatchFetcher.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek  on 04.09.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
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
                        self.requestSender.send(self.currentRequest, withResponseHandler: self.responseHandler(completion))
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
