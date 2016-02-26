//
//  CreatubblesAPIClient.swift
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

//MARK: - Typealiases
public typealias ErrorClousure = (ErrorType?) -> (Void)

public typealias UserClousure = (User?, ErrorType?) -> (Void)
public typealias UsersClousure = (Array<User>?,PagingInfo? ,ErrorType?) -> (Void)
public typealias UsersBatchClousure = (Array<User>? ,ErrorType?) -> (Void)

public typealias CreationClousure = (Creation?, ErrorType?) -> (Void)
public typealias CreationsClousure = (Array<Creation>?, PagingInfo?, ErrorType?) -> (Void)
public typealias CreationsBatchClousure = (Array<Creation>?, ErrorType?) -> (Void)

public typealias GalleryClousure = (Gallery?, ErrorType?) -> (Void)
public typealias GalleriesClousure = (Array<Gallery>?, PagingInfo?, ErrorType?) -> (Void)
public typealias GalleriesBatchClousure = (Array<Gallery>?, ErrorType?) -> (Void)

//MARK: - Enums
@objc public enum Gender: Int
{
    case Male = 0
    case Female = 1
}

@objc public enum SortOrder: Int
{
    case Popular
    case Recent
}
/**

 */
public class CreatubblesAPIClient: NSObject
{
    //MARK: - Internal
    private let settings: CreatubblesAPIClientSettings
    private let requestSender: RequestSender
    private let creationsDAO: CreationsDAO
    private let userDAO: UserDAO
    private let galleryDAO: GalleryDAO
    private let creationUploadService: CreationUploadService
    
    public init(settings: CreatubblesAPIClientSettings)
    {
        self.settings = settings
        self.requestSender = RequestSender(settings: settings)
        self.creationsDAO = CreationsDAO(requestSender: requestSender)
        self.userDAO = UserDAO(requestSender: requestSender)
        self.galleryDAO = GalleryDAO(requestSender: requestSender)
        self.creationUploadService = CreationUploadService(requestSender: requestSender)
        Logger.setup()
    }
    
    //MARK: - Authentication
    public func authenticationToken() -> String?
    {
        return requestSender.authenticationToken;
    }
    
    public func login(username: String, password: String, completion:ErrorClousure?)
    {
        requestSender.login(username, password: password, completion: completion)
    }
    
    public func logout()
    {
        requestSender.logout()
    }
    
    public func isLoggedIn() -> Bool
    {
        return requestSender.isLoggedIn()
    }
    
    //MARK: - Creators managment
    public func getUser(userId: String, completion: UserClousure)
    {
        userDAO.getUser(userId, completion: completion)
    }
    
    public func getCurrentUser(completion: UserClousure)
    {
        userDAO.getCurrentUser(completion)
    }
    
    public func getCreators(userId: String?, pagingData: PagingData?, completion: UsersClousure?)
    {
        userDAO.getCreators(userId, pagingData: pagingData, completion: completion)
    }
    
    public func getManagers(userId: String?, pagingData: PagingData?, completion: UsersClousure?)
    {
        userDAO.getManagers(userId, pagingData: pagingData, completion: completion)
    }

    public func getCreators(userId: String?, completion: UsersBatchClousure?)
    {
        userDAO.getCreators(userId, completion: completion)
    }
    
    public func getManagers(userId: String?, completion: UsersBatchClousure?)
    {
        userDAO.getManagers(userId, completion: completion)
    }
    
    public func newCreator(creatorData: NewCreatorData,completion: UserClousure?)
    {
        userDAO.newCreator(creatorData, completion: completion)
    }
    
    //MARK: - Gallery managment
    public func getGallery(galleryId: String, completion: GalleryClousure?)
    {
        galleryDAO.getGallery(galleryId, completion: completion)
    }
    
    public func getGalleries(userId: String?, pagingData: PagingData?, sort: SortOrder?, completion: GalleriesClousure?)
    {
        galleryDAO.getGalleries(userId, pagingData: pagingData, sort: sort, completion: completion)
    }
    
    public func getGalleries(userId: String?, sort: SortOrder?, completion: GalleriesBatchClousure?)
    {
        galleryDAO.getGalleries(userId, sort: sort, completion: completion)
    }
    
    public func newGallery(galleryData: NewGalleryData, completion: GalleryClousure?)
    {
        galleryDAO.newGallery(galleryData, completion: completion)
    }
    
    //MARK: - Creation managment
    public func getCreation(creationId: String, completion: CreationClousure?)
    {
        creationsDAO.getCreation(creationId, completion: completion)
    }
    
    public func getCreations(galleryId: String?, userId: String?, keyword: String?, pagingData: PagingData?, sortOrder: SortOrder?, completion: CreationsClousure?)
    {
        creationsDAO.getCreations(galleryId, userId: userId, keyword: keyword, pagingData: pagingData, sortOrder: sortOrder, completion: completion)
    }
    
    public func getCreations(galleryId: String?, userId: String?, keyword: String?, sortOrder: SortOrder?, completion: CreationsBatchClousure?)
    {
        creationsDAO.getCreations(galleryId, userId: userId, keyword: keyword, sortOrder: sortOrder, completion: completion)
    }
    
    public func newCreation(creationData: NewCreationData, completion: CreationClousure?)
    {
        creationUploadService.uploadCreation(creationData, completion: completion)
    }
}
