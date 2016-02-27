//
//  CreatubblesAPIClient.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 05.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

//add protocol

public class CreatubblesAPIClient: NSObject, CreationUploadServiceDelegate
{
    //MARK: - Internal
    private let settings: CreatubblesAPIClientSettings
    private let requestSender: RequestSender
    private let creationsDAO: CreationsDAO
    private let userDAO: UserDAO
    private let galleryDAO: GalleryDAO
    private let creationUploadService: CreationUploadService
    weak var delegate: CreationUploadServiceDelegate?
    
    public init(settings: CreatubblesAPIClientSettings)
    {
        self.settings = settings
        self.requestSender = RequestSender(settings: settings)
        self.creationsDAO = CreationsDAO(requestSender: requestSender)
        self.userDAO = UserDAO(requestSender: requestSender)
        self.galleryDAO = GalleryDAO(requestSender: requestSender)
        self.creationUploadService = CreationUploadService(requestSender: requestSender)
        super.init()
        self.creationUploadService.delegate = self
    }
    
    //MARK: - Authentication
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
    
    public func newCreator(creatorData: NewCreatorData,completion: UserClousure?)
    {
        userDAO.newCreator(creatorData, completion: completion)
    }
    
    //MARK: - Gallery managment
    public func getGallery(galleryId: String, completion: GalleryClousure?)
    {
        galleryDAO.getGallery(galleryId, completion: completion)
    }
    
    public func getGalleries(userId: String?, pagingData: PagingData, sort: SortOrder, completion: GalleriesClousure?)
    {
        galleryDAO.getGalleries(userId, pagingData: pagingData, sort: sort, completion: completion)
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
    
    public func getCreations(galleryId: String, userId: String?, keyword: String?, pagingData: PagingData?, sortOrder: SortOrder?, completion: CreationsClousure?)
    {
        creationsDAO.getCreations(galleryId, userId: userId, keyword: keyword, pagingData: pagingData, sortOrder: sortOrder, completion: completion)
    }
    
    public func newCreation(creationData: NewCreationData, completion: CreationClousure?)
    {
        creationUploadService.uploadCreation(creationData, completion: completion)
    }
    
    func creationUploadSessionUploadFinished(creationUploadService: CreationUploadSession)
    {
        
    }
    
    func creationUploadSessionProgressChanged(creationUploadSession: CreationUploadSession, bytesWritten: Int, totalBytesWritten: Int, totalBytesExpectedToWrite: Int)
    {
        
    }
}
