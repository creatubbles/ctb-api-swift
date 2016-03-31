//
//  GalleryDAO.swift
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

import UIKit

class GalleryDAO
{
    private let requestSender: RequestSender
    
    init(requestSender: RequestSender)
    {
        self.requestSender = requestSender
    }
    
    func getGallery(galleryId: String, completion: GalleryClosure?) -> RequestHandler
    {
        let request = GalleriesRequest(galleryId: galleryId)
        let handler = GalleriesResponseHandler
        {
            (galleries, pageInfo, error) -> Void in
            completion?(galleries?.first, error)
        }
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getGalleries(userId: String?, pagingData: PagingData?, sort: SortOrder?, completion: GalleriesClosure?) -> RequestHandler
    {
        let request = GalleriesRequest(page: pagingData?.page, perPage: pagingData?.pageSize, sort: sort, userId: userId)
        let handler = GalleriesResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func newGallery(galleryData: NewGalleryData, completion: GalleryClosure?) -> RequestHandler
    {
        let request = NewGalleryRequest(name: galleryData.name, galleryDescription: galleryData.galleryDescription, openForAll: galleryData.openForAll, ownerId: galleryData.ownerId)
        let handler = NewGalleryResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }

    func getGalleries(userId: String?, sort: SortOrder?, completion: GalleriesBatchClosure?) -> RequestHandler
    {
        let fetcher = GalleriesBatchFetcher(requestSender: requestSender)
        return fetcher.fetch(userId, sort: sort, completion: completion)
    }
}
