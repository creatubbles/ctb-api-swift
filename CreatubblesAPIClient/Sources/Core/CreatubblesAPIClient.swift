//
//  CreatubblesAPIClient.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 05.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

public class CreatubblesAPIClient: NSObject
{
    //MARK: - Internal
    private let settings: CreatubblesAPIClientSettings
    private let requestSender: RequestSender
    private let creationsDAO: CreationsDAO
    private let userDAO: UserDAO
    private let galleryDAO: GalleryDAO
    
    public init(settings: CreatubblesAPIClientSettings)
    {
        self.settings = settings
        self.requestSender = RequestSender(settings: settings)
        self.creationsDAO = CreationsDAO(requestSender: requestSender)
        self.userDAO = UserDAO(requestSender: requestSender)
        self.galleryDAO = GalleryDAO(requestSender: requestSender)
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
    }
    
    public func getGalleries(completion: GalleriesClousure?)
    {
    
    }
    
    public func newGallery(completion: GalleryClousure?)
    {
    
    }
    
    //MARK: - Creation managment
    public func getCreation(creationId: String, completion: CreationClousure?)
    {
        
    }
    
    public func getCreations(completion: CreationsClousure?)
    {
    
    }
    
    public func newCreation(completion: CreationClousure?)
    {
        
    }
}
