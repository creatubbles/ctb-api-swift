//
//  GalleryDAO.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 18.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class GalleryDAO
{
    private let requestSender: RequestSender
    
    init(requestSender: RequestSender)
    {
        self.requestSender = requestSender
    }
    
    func getGallery(galleryId: String, completion: GalleryClousure?)
    {
        let request = GalleriesRequest(galleryId: galleryId)
        let handler = GalleriesResponseHandler
        {
            (galleries, error) -> Void in
            completion?(galleries?.first, error)
        }
        requestSender.send(request, withResponseHandler: handler)
    }
    
    func getGalleries(userId: String?, pagingData: PagingData, sort: SortOrder, completion: GalleriesClousure?)
    {
        let request = GalleriesRequest(page: pagingData.page, perPage: pagingData.pageSize, sort: sort, userId: userId)
        let handler = GalleriesResponseHandler(completion: completion)
        requestSender.send(request, withResponseHandler: handler)
    }
    
    func newGallery(galleryData: NewGalleryData, completion: GalleryClousure?)
    {
        let request = NewGalleryRequest(name: galleryData.name, galleryDescription: galleryData.galleryDescription, openForAll: galleryData.openForAll, ownerId: galleryData.ownerId)
        let handler = NewGalleryResponseHandler(completion: completion)
        requestSender.send(request, withResponseHandler: handler)
    }
}
