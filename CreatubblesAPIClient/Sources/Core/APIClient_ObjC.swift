//
//  CreatubblesAPIClient_ObjC.swift
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
extension APIClient
{
    //MARK: - Session
    public func _login(_ username: String, password: String, completion: ((NSError?) -> (Void))?)
    {
        login(username: username, password: password)
        {
            (error) -> (Void) in
            (completion?(APIClient.errorTypeToNSError(error)))!
        }
    }
    
    public func _logout()
    {
        logout()
    }
    
    public func _isLoggedIn() -> Bool
    {
        return isLoggedIn()
    }
    
    public func _authenticationToken() -> String?
    {
        return authenticationToken()
    }
    
    public func _getLandingURL(_ type: LandingURLType, completion: ((Array<LandingURL>? ,NSError?) -> (Void))?)
    {
        getLandingURL(type: type)
        {
            (landingUrls, error) -> (Void) in
            (completion?(landingUrls, APIClient.errorTypeToNSError(error)))!
        }
    }
    
    public func _getLandingURLForCreation(_ creationId: String, completion: ((Array<LandingURL>? ,NSError?) -> (Void))?)
    {
        getLandingURL(creationId: creationId)
        {
            (landingUrls, error) -> (Void) in
            (completion?(landingUrls, APIClient.errorTypeToNSError(error)))!
        }
    }
    
    //MARK: - Users handling       
    public func _getUser(_ userId: String, completion: ((User?, NSError?) -> (Void))?)
    {
        getUser(userId: userId)
        {
            (user, error) -> (Void) in
            (completion?(user, APIClient.errorTypeToNSError(error)))!
        }
    }
    
    public func _getCurrentUser(_ completion: ((User?, NSError?) -> (Void))?)
    {
        getCurrentUser()
        {
            (user, error) -> (Void) in
            (completion?(user, APIClient.errorTypeToNSError(error)))!
        }
    }
    
    public func _getCreators(_ userId: String?, pagingData: PagingData?, completion: ((Array<User>?,PagingInfo? ,NSError?) -> (Void))?)
    {
        getCreators(userId: userId, pagingData: pagingData)
        {
            (users, pInfo, error) -> (Void) in
            (completion?(users, pInfo, APIClient.errorTypeToNSError(error)))!
        }
    }
    
    public func _getManagers(_ userId: String?, pagingData: PagingData?, completion: ((Array<User>?,PagingInfo?, NSError?) -> (Void))?)
    {
        getManagers(userId: userId, pagingData: pagingData)
        {
            (users, pInfo, error) -> (Void) in
            (completion?(users, pInfo, APIClient.errorTypeToNSError(error)))!
        }
    }
    
    public func _newCreator(_ creatorData: NewCreatorData, completion: ((User?, NSError?) -> (Void))?)
    {
        newCreator(data: creatorData)
        {
            (user, error) -> (Void) in
            (completion?(user, APIClient.errorTypeToNSError(error)))!
        }
    }
    
    //MARK: - Gallery handling
    public func _getGallery(_ galleryId: String, completion: ((Gallery?, NSError?) -> (Void))?)
    {
        getGallery(galleryId: galleryId)
        {
            (gallery, error) -> (Void) in
            (completion?(gallery, APIClient.errorTypeToNSError(error)))!
        }
    }
    
    public func _newGallery(_ galleryData: NewGalleryData, completion: ((Gallery?, NSError?) -> (Void))?)
    {
        newGallery(data: galleryData)
        {
            (gallery, error) -> (Void) in
            (completion?(gallery, APIClient.errorTypeToNSError(error)))!
        }
    }
    
    public func _getGalleries(_ userId: String?, pagingData: PagingData?, sort: SortOrder, completion: ((Array<Gallery>?, PagingInfo?, NSError?) -> (Void))?)
    {
        getGalleries(userId: userId, pagingData: pagingData, sort: sort)
        {
            (galleries, pInfo, error) -> (Void) in
            (completion?(galleries, pInfo, APIClient.errorTypeToNSError(error)))!
        }
    }
    
    //MARK: - Creation handling
    public func _getCreation(_ creationId: String, completion: ((Creation?, NSError?) -> (Void))?)
    {
        getCreation(creationId: creationId)
        {
            (creation, error) -> (Void) in
            (completion?(creation, APIClient.errorTypeToNSError(error)))!
        }
    }
    
    public func _getCreations(_ galleryId: String, userId: String?, keyword: String?, pagingData: PagingData?, sortOrder: SortOrder, onlyPublic: Bool, completion: ((Array<Creation>?, PagingInfo?, NSError?) -> (Void))?)
    {
        getCreations(galleryId: galleryId, userId: userId, keyword: keyword, pagingData: pagingData, sortOrder: sortOrder, onlyPublic: onlyPublic)
        {
            (creations, pInfo, error) -> (Void) in
            (completion?(creations, pInfo, APIClient.errorTypeToNSError(error)))!
        }
    }
    
    public func _newCreation(_ creationData: NewCreationData, completion: ((Creation?, NSError?) -> (Void))?)
    {
        newCreation(data: creationData)
        {
            (creation, error) -> (Void) in
            (completion?(creation, APIClient.errorTypeToNSError(error)))!
        }
    }
    
    //MARK: - Batch fetching
    public func _getCreationsInBatchMode(_ galleryId: String?, userId: String?, keyword: String?, sortOrder: SortOrder, onlyPublic: Bool, completion: ((Array<Creation>?, NSError?) -> (Void))?)
    {
        getCreationsInBatchMode(galleryId: galleryId, userId: userId, keyword: keyword, sortOrder: sortOrder, onlyPublic: onlyPublic)
        {
            (creations, error) -> (Void) in
            (completion?(creations, APIClient.errorTypeToNSError(error)))!
        }
    }
    
    public func _getGalleriesInBatchMode(_ userId: String?, sort: SortOrder, completion: ((Array<Gallery>?, NSError?) -> (Void))?)
    {
        getGalleriesInBatchMode(userId: userId, sort: sort)
        {
            (galleries, error) -> (Void) in
            (completion?(galleries, APIClient.errorTypeToNSError(error)))!
        }
    }
    
    public func _getCreatorsInBatchMode(_ userId: String?, completion: ((Array<User>?,NSError?) -> (Void))?)
    {
        getCreatorsInBatchMode(userId: userId)
        {
            (users, error) -> (Void) in
            (completion?(users, APIClient.errorTypeToNSError(error)))!
        }
    }
    
    public func _getManagersInBatchMode(_ userId: String?, completion: ((Array<User>?,NSError?) -> (Void))?)
    {
        getManagersInBatchMode(userId: userId)
        {
            (users, error) -> (Void) in
            (completion?(users, APIClient.errorTypeToNSError(error)))!
        }
    }
    
    //MARK: - Upload Sessions
    public func _getAllActiveUploadSessionPublicData() -> Array<CreationUploadSessionPublicData>
    {
        return getAllActiveUploadSessionPublicData()
    }
    
    public func _getAllFinishedUploadSessionPublicData() -> Array<CreationUploadSessionPublicData>
    {
        return getAllFinishedUploadSessionPublicData()
    }
    
    public func _startAllNotFinishedUploadSessions(_ completion: ((Creation?, NSError?) -> (Void))?)
    {
        startAllNotFinishedUploadSessions {
            (creation, error) -> (Void) in
            (completion?(creation, APIClient.errorTypeToNSError(error)))!
        }
    }
    
    //MARK: - Bubbles
    func _getBubblesForCreationWithIdentifier(_ identifier: String, pagingData: PagingData?, completion: ((Array<Bubble>?, PagingInfo?, NSError?) -> (Void))?)
    {
        getBubbles(creationId: identifier, pagingData: pagingData)
        {
            (bubbles, pInfo, error) -> (Void) in
            (completion?(bubbles, pInfo, APIClient.errorTypeToNSError(error)))!
        }
    }
    
    func _getBubblesForUserWithIdentifier(_ identifier: String, pagingData: PagingData?, completion: ((Array<Bubble>?,PagingInfo?, NSError?) -> (Void))?)
    {
        getBubbles(userId: identifier, pagingData: pagingData)
        {
            (bubbles, pInfo, error) -> (Void) in
            (completion?(bubbles, pInfo, APIClient.errorTypeToNSError(error as! Error?)))!
        }
    }
    
    func _getBubblesForGalleryWithIdentifier(_ identifier: String, pagingData: PagingData?, completion: ((Array<Bubble>?, PagingInfo?, NSError?) -> (Void))?)
    {
        getBubbles(galleryId: identifier, pagingData: pagingData)
        {
            (bubbles, pInfo, error) -> (Void) in
            (completion?(bubbles, pInfo, APIClient.errorTypeToNSError(error as! Error?)))!
        }
    }
    
    func _newBubble(_ data: NewBubbleData, completion: ((Bubble?, NSError?) -> (Void))?)
    {
        newBubble(data: data)
        {
            (bubble, error) -> (Void) in
            (completion?(bubble, APIClient.errorTypeToNSError(error)))!
        }
    }
    
    func _updateBubble(_ data: UpdateBubbleData, completion: ((Bubble?, NSError?) -> (Void))?)
    {
        updateBubble(data: data)
            {
                (bubble, error) -> (Void) in
                (completion?(bubble, APIClient.errorTypeToNSError(error)))!
        }
    }

    //MARK: - Utils
    static func errorTypeToNSError(_ error: Error?) -> NSError?
    {
        if let error = error as? APIClientError
        {
            let userInfo = [NSLocalizedDescriptionKey : error.title]
            return NSError(domain: APIClientError.DefaultDomain, code: error.status, userInfo: userInfo)
        }
        if let _ = error
        {
            let userInfo = [NSLocalizedDescriptionKey :String(describing: error)]
            return NSError(domain: APIClientError.DefaultDomain, code: APIClientError.UnknownStatus, userInfo: userInfo)
        }
        return nil
    }

}
