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
extension CreatubblesAPIClient
{
    //MARK: - Session
    public func _login(username: String, password: String, completion: ((NSError?) -> (Void))?)
    {
        login(username, password: password)
        {
            (error) -> (Void) in
            completion?(CreatubblesAPIClient.errorTypeToNSError(error))
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
    
    //MARK: - Users handling
    public func _authenticationToken() -> String?
    {
        return authenticationToken()
    }
    
    public func _getUser(userId: String, completion: ((User?, NSError?) -> (Void))?)
    {
        getUser(userId)
        {
            (user, error) -> (Void) in
            completion?(user, CreatubblesAPIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getCurrentUser(completion: ((User?, NSError?) -> (Void))?)
    {
        getCurrentUser()
        {
            (user, error) -> (Void) in
            completion?(user, CreatubblesAPIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getCreators(userId: String?, pagingData: PagingData?, completion: ((Array<User>?,PagingInfo? ,NSError?) -> (Void))?)
    {
        getCreators(userId, pagingData: pagingData)
        {
            (users, pInfo, error) -> (Void) in
            completion?(users, pInfo,CreatubblesAPIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getManagers(userId: String?, pagingData: PagingData?, completion: ((Array<User>?,PagingInfo?, NSError?) -> (Void))?)
    {
        getManagers(userId, pagingData: pagingData)
        {
            (users, pInfo, error) -> (Void) in
            completion?(users, pInfo,CreatubblesAPIClient.errorTypeToNSError(error))
        }
    }
    
    public func _newCreator(creatorData: NewCreatorData, completion: ((User?, NSError?) -> (Void))?)
    {
        newCreator(creatorData)
        {
            (user, error) -> (Void) in
            completion?(user, CreatubblesAPIClient.errorTypeToNSError(error))
        }
    }
    
    //MARK: - Gallery handling
    public func _getGallery(galleryId: String, completion: ((Gallery?, NSError?) -> (Void))?)
    {
        getGallery(galleryId)
        {
            (gallery, error) -> (Void) in
            completion?(gallery, CreatubblesAPIClient.errorTypeToNSError(error))
        }
    }
    
    public func _newGallery(galleryData: NewGalleryData, completion: ((Gallery?, NSError?) -> (Void))?)
    {
        newGallery(galleryData)
        {
            (gallery, error) -> (Void) in
            completion?(gallery, CreatubblesAPIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getGalleries(userId: String?, pagingData: PagingData?, sort: SortOrder, completion: ((Array<Gallery>?, PagingInfo?, NSError?) -> (Void))?)
    {
        getGalleries(userId, pagingData: pagingData, sort: sort)
        {
            (galleries, pInfo, error) -> (Void) in
            completion?(galleries, pInfo, CreatubblesAPIClient.errorTypeToNSError(error))
        }
    }
    
    //MARK: - Creation handling
    public func _getCreation(creationId: String, completion: ((Creation?, NSError?) -> (Void))?)
    {
        getCreation(creationId)
        {
            (creation, error) -> (Void) in
            completion?(creation, CreatubblesAPIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getCreations(galleryId: String, userId: String?, keyword: String?, pagingData: PagingData?, sortOrder: SortOrder, completion: ((Array<Creation>?, PagingInfo?, NSError?) -> (Void))?)
    {
        getCreations(galleryId, userId: userId, keyword: keyword, pagingData: pagingData, sortOrder: sortOrder)
        {
            (creations, pInfo, error) -> (Void) in
            completion?(creations, pInfo, CreatubblesAPIClient.errorTypeToNSError(error))
        }
    }
    
    public func _newCreation(creationData: NewCreationData, completion: ((Creation?, NSError?) -> (Void))?)
    {
        newCreation(creationData)
        {
            (creation, error) -> (Void) in
            completion?(creation, CreatubblesAPIClient.errorTypeToNSError(error))
        }
    }
    
    //MARK: - Batch fetching

    public func _getCreations(galleryId: String?, userId: String?, keyword: String?, sortOrder: SortOrder, completion: ((Array<Creation>?, NSError?) -> (Void))?)
    {
        getCreations(galleryId, userId: userId, keyword: keyword, sortOrder: sortOrder)
        {
            (creations, error) -> (Void) in
            completion?(creations, CreatubblesAPIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getGalleries(userId: String?, sort: SortOrder, completion: ((Array<Gallery>?, NSError?) -> (Void))?)
    {
        getGalleries(userId, sort: sort)
        {
            (galleries, error) -> (Void) in
            completion?(galleries, CreatubblesAPIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getCreators(userId: String?, completion: ((Array<User>?,NSError?) -> (Void))?)
    {
        getCreators(userId)
        {
            (users, error) -> (Void) in
            completion?(users, CreatubblesAPIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getManagers(userId: String?, completion: ((Array<User>?,NSError?) -> (Void))?)
    {
        getManagers(userId)
        {
            (users, error) -> (Void) in
            completion?(users, CreatubblesAPIClient.errorTypeToNSError(error))
        }
    }

    //MARK: - Utils
    static func errorTypeToNSError(error: ErrorType?) -> NSError?
    {
        if let error = error
        {
            let userInfo = [NSLocalizedDescriptionKey :String(error)]
            return NSError(domain: "com.creatubbles.errordomain", code: 1, userInfo: userInfo)
        }
        return nil
    }

}