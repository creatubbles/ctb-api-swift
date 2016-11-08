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
    fileprivate let requestSender: RequestSender
    
    init(requestSender: RequestSender)
    {
        self.requestSender = requestSender
    }
    
    func submitCreationToGallery(galleryIdentifier galleryId: String, creationId: String, completion: @escaping ErrorClosure) -> RequestHandler
    {
        let request = GallerySubmissionRequest(galleryId: galleryId, creationId: creationId)
        let handler = GallerySubmissionResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getGallery(galleryIdentifier galleryId: String, completion: GalleryClosure?) -> RequestHandler
    {
        let request = GalleriesRequest(galleryId: galleryId)
        let handler = GalleriesResponseHandler
        {
            (galleries, pageInfo, error) -> Void in
            completion?(galleries?.first, error)
        }
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func updateGallery(data: UpdateGalleryData, completion: ErrorClosure?) -> RequestHandler
    {
        let request = UpdateGalleryRequest(data: data)
        let handler = UpdateGalleryResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func reportGallery(galleryIdentifier galleryId: String, message: String, completion: ErrorClosure?) -> RequestHandler
    {
        let request = ReportGalleryRequest(galleryId: galleryId, message: message)
        let handler = ReportGalleryResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getGalleries(userIdentifier userId: String?, pagingData: PagingData?, sort: SortOrder?, completion: GalleriesClosure?) -> RequestHandler
    {
        let request = GalleriesRequest(page: pagingData?.page, perPage: pagingData?.pageSize, sort: sort, userId: userId)
        let handler = GalleriesResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getGalleries(creationIdentifier creationId: String, pagingData: PagingData?, sort: SortOrder?, completion: GalleriesClosure?) -> RequestHandler
    {
        let request = GalleriesRequest(creationId: creationId, page: pagingData?.page, perPage: pagingData?.pageSize, sort: sort)
        let handler = GalleriesResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getMyGalleries(_ pagingData: PagingData?, completion: GalleriesClosure?) -> RequestHandler
    {
        let request = MyGalleriesRequest(page: pagingData?.page, perPage: pagingData?.pageSize, filter: .none)
        let handler = GalleriesResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getMyOwnedGalleries(_ pagingData: PagingData?, completion: GalleriesClosure?) -> RequestHandler
    {
        let request = MyGalleriesRequest(page: pagingData?.page, perPage: pagingData?.pageSize, filter: .owned)
        let handler = GalleriesResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getMySharedGalleries(_ pagingData: PagingData?, completion: GalleriesClosure?) -> RequestHandler
    {
        let request = MyGalleriesRequest(page: pagingData?.page, perPage: pagingData?.pageSize, filter: .shared )
        let handler = GalleriesResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getMyFavoriteGalleries(_ pagingData: PagingData?, completion: GalleriesClosure?) -> RequestHandler
    {
        let request = FavoriteGalleriesRequest(page: pagingData?.page, perPage: pagingData?.pageSize)
        let handler = GalleriesResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getFeaturedGalleries(_ pagingData: PagingData?, completion: GalleriesClosure?) -> RequestHandler
    {
        let request = FeaturedGalleriesRequest(page: pagingData?.page, perPage: pagingData?.pageSize)
        let handler = GalleriesResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func newGallery(data galleryData: NewGalleryData, completion: GalleryClosure?) -> RequestHandler
    {
        let request = NewGalleryRequest(name: galleryData.name, galleryDescription: galleryData.galleryDescription, openForAll: galleryData.openForAll, ownerId: galleryData.ownerId)
        let handler = NewGalleryResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }

    //MARK: Batch Mode    
    func getGalleriesInBatchMode(userIdentifier userId: String?, sort: SortOrder?, completion: GalleriesBatchClosure?) -> RequestHandler
    {
        let fetcher = GalleriesBatchFetcher(requestSender: requestSender)
        return fetcher.fetch(userId, sort: sort, completion: completion)
    }
    
    func getMyGalleriesInBatchMode(_ completion: GalleriesBatchClosure?) -> RequestHandler
    {
        let fetcher = MyGalleriesBatchFetcher(requestSender: requestSender)
        return fetcher.fetch(.none, completion: completion)
    }
    
    func getMyOwnedGalleriesInBatchMode(_ completion: GalleriesBatchClosure?) -> RequestHandler
    {
        let fetcher = MyGalleriesBatchFetcher(requestSender: requestSender)
        return fetcher.fetch(.owned, completion: completion)
    }
    
    func getMySharedGalleriesInBatchMode(_ completion: GalleriesBatchClosure?) -> RequestHandler
    {
        let fetcher = MyGalleriesBatchFetcher(requestSender: requestSender)
        return fetcher.fetch(.shared, completion: completion)
    }
    
    func getFavoriteGalleriesInBatchMode(_ completion: GalleriesBatchClosure?) -> RequestHandler
    {
        let fetcher = FavoriteGalleriesBatchFetcher(requestSender: requestSender)
        return fetcher.fetch(completion)
    }
    
    func getFeaturedGalleriesInBatchMode(_ completion: GalleriesBatchClosure?) -> RequestHandler
    {
        let fetcher = FeaturedGalleriesBatchFetcher(requestSender: requestSender)
        return fetcher.fetch(completion)
    }
}
