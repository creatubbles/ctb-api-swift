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
public typealias ErrorClosure = (APIClientError?) -> (Void)

public typealias UserClosure = (User?, APIClientError?) -> (Void)
public typealias UsersClosure = (Array<User>?,PagingInfo? ,APIClientError?) -> (Void)
public typealias UsersBatchClosure = (Array<User>? ,APIClientError?) -> (Void)

public typealias CreationClosure = (Creation?, APIClientError?) -> (Void)
public typealias CreationsClosure = (Array<Creation>?, PagingInfo?, APIClientError?) -> (Void)
public typealias CreationsBatchClosure = (Array<Creation>?, APIClientError?) -> (Void)

public typealias GalleryClosure = (Gallery?, APIClientError?) -> (Void)
public typealias GalleriesClosure = (Array<Gallery>?, PagingInfo?, APIClientError?) -> (Void)
public typealias GalleriesBatchClosure = (Array<Gallery>?, APIClientError?) -> (Void)

public typealias LandingURLClosure = (Array<LandingURL>?, APIClientError?) -> (Void)

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

@objc public enum LandingURLType: Int
{
    case AboutUs
    case TermsOfUse
    case PrivacyPolicy
    case Registration
    case UserProfile
    case Explore
    case Creation
    case ForgotPassword
}

@objc
public protocol APIClientDelegate
{
    func creatubblesAPIClientImageUploadFinished(apiClient: APIClient, uploadSessionData: CreationUploadSessionPublicData)
    func creatubblesAPIClientImageUploadFailed(apiClient: APIClient,  uploadSessionData: CreationUploadSessionPublicData, error: NSError)
    func creatubblesAPIClientImageUploadProcessChanged(apiClient: APIClient, uploadSessionData: CreationUploadSessionPublicData, bytesUploaded: Int, bytesExpectedToUpload: Int)
}

public protocol Cancelable
{
    func cancel()
}

@objc
public class APIClient: NSObject, CreationUploadServiceDelegate
{
    //MARK: - Internal
    private let settings: APIClientSettings
    private let requestSender: RequestSender
    private let creationsDAO: CreationsDAO
    private let userDAO: UserDAO
    private let galleryDAO: GalleryDAO
    private let creationUploadService: CreationUploadService
    private let databaseDAO: DatabaseDAO
    public weak var delegate: APIClientDelegate?
    
    public init(settings: APIClientSettings)
    {
        self.settings = settings
        self.requestSender = RequestSender(settings: settings)
        self.creationsDAO = CreationsDAO(requestSender: requestSender)
        self.userDAO = UserDAO(requestSender: requestSender)
        self.galleryDAO = GalleryDAO(requestSender: requestSender)
        self.creationUploadService = CreationUploadService(requestSender: requestSender)
        self.databaseDAO = DatabaseDAO()
        Logger.setup()
        super.init()
        self.creationUploadService.delegate = self
    }
    
    //MARK: - Authentication
    public func authenticationToken() -> String?
    {
        return requestSender.authenticationToken;
    }
    
    public func login(username: String, password: String, completion:ErrorClosure?) -> RequestHandler
    {
        return requestSender.login(username, password: password, completion: completion)
    }
    
    public func logout()
    {
        requestSender.logout()
    }
    
    public func isLoggedIn() -> Bool
    {
        return requestSender.isLoggedIn()
    }
    
    public func getLandingURL(type: LandingURLType?, completion: LandingURLClosure?) -> RequestHandler
    {
        return userDAO.getLandingURL(type, completion: completion)
    }

    public func getLandingURL(creationId: String, completion: LandingURLClosure?) -> RequestHandler
    {
        return userDAO.getLandingURL(creationId, completion: completion)
    }
    
    //MARK: - Creators managment
    public func getUser(userId: String, completion: UserClosure?) -> RequestHandler
    {
        return userDAO.getUser(userId, completion: completion)
    }
    
    public func getCurrentUser(completion: UserClosure?) -> RequestHandler
    {
        return userDAO.getCurrentUser(completion)
    }
    
    public func getCreators(userId: String?, pagingData: PagingData?, completion: UsersClosure?) -> RequestHandler
    {
        return userDAO.getCreators(userId, pagingData: pagingData, completion: completion)
    }
    
    public func getManagers(userId: String?, pagingData: PagingData?, completion: UsersClosure?) -> RequestHandler
    {
        return userDAO.getManagers(userId, pagingData: pagingData, completion: completion)
    }

    public func getCreators(userId: String?, completion: UsersBatchClosure?) -> RequestHandler
    {
        return userDAO.getCreators(userId, completion: completion)
    }
    
    public func getManagers(userId: String?, completion: UsersBatchClosure?) -> RequestHandler
    {
        return userDAO.getManagers(userId, completion: completion)
    }
    
    public func newCreator(creatorData: NewCreatorData,completion: UserClosure?) -> RequestHandler
    {
        return userDAO.newCreator(creatorData, completion: completion)
    }
    
    //MARK: - Gallery managment
    public func getGallery(galleryId: String, completion: GalleryClosure?) -> RequestHandler
    {
        return galleryDAO.getGallery(galleryId, completion: completion)
    }
    
    public func getGalleries(userId: String?, pagingData: PagingData?, sort: SortOrder?, completion: GalleriesClosure?) -> RequestHandler
    {
        return galleryDAO.getGalleries(userId, pagingData: pagingData, sort: sort, completion: completion)
    }
    
    public func getGalleries(userId: String?, sort: SortOrder?, completion: GalleriesBatchClosure?) -> RequestHandler
    {
        return galleryDAO.getGalleries(userId, sort: sort, completion: completion)
    }
    
    public func newGallery(galleryData: NewGalleryData, completion: GalleryClosure?) -> RequestHandler
    {
        return galleryDAO.newGallery(galleryData, completion: completion)
    }
    
    //MARK: - Creation managment
    public func getCreation(creationId: String, completion: CreationClosure?) -> RequestHandler
    {
        return creationsDAO.getCreation(creationId, completion: completion)
    }
    
    public func getCreations(galleryId: String?, userId: String?, keyword: String?, pagingData: PagingData?, sortOrder: SortOrder?, completion: CreationsClosure?) -> RequestHandler
    {
        return creationsDAO.getCreations(galleryId, userId: userId, keyword: keyword, pagingData: pagingData, sortOrder: sortOrder, completion: completion)
    }
    
    public func getCreations(galleryId: String?, userId: String?, keyword: String?, sortOrder: SortOrder?, completion: CreationsBatchClosure?) -> RequestHandler
    {
        return creationsDAO.getCreations(galleryId, userId: userId, keyword: keyword, sortOrder: sortOrder, completion: completion)
    }
    
    //MARK: - Upload Sessions
    public func getAllActiveUploadSessionPublicData() -> Array<CreationUploadSessionPublicData>
    {
        return databaseDAO.getAllActiveUploadSessionsPublicData(requestSender)
    }
    
    public func getAllFinishedUploadSessionPublicData() -> Array<CreationUploadSessionPublicData>
    {
        return databaseDAO.getAllFinishedUploadSessionsPublicData(requestSender)
    }
    
    public func startAllNotFinishedUploadSessions(completion: CreationClosure?)
    {
        creationUploadService.startAllNotFinishedUploadSessions(completion)
    }
    
    //MARK: - Creation flow
    public func newCreation(creationData: NewCreationData, completion: CreationClosure?)
    {
        creationUploadService.uploadCreation(creationData, completion: completion)
    }
    
    //MARK: - Background session
    public var backgroundCompletionHandler: (() -> Void)?
    {
        get
        {
            return requestSender.backgroundCompletionHandler
        }
        set
        {
            requestSender.backgroundCompletionHandler = newValue
        }
    }
    
    //MARK: - Delegate
    func creationUploadServiceUploadFinished(service: CreationUploadService, session: CreationUploadSession)
    {
        let data = CreationUploadSessionPublicData(creationUploadSession: session)
        delegate?.creatubblesAPIClientImageUploadFinished(self, uploadSessionData: data)
    }
    
    func creationUploadServiceProgressChanged(service: CreationUploadService, session: CreationUploadSession, bytesWritten: Int, totalBytesWritten: Int, totalBytesExpectedToWrite: Int)
    {
        let data = CreationUploadSessionPublicData(creationUploadSession: session)
        delegate?.creatubblesAPIClientImageUploadProcessChanged(self, uploadSessionData: data, bytesUploaded: totalBytesWritten, bytesExpectedToUpload: totalBytesExpectedToWrite)
    }
    
    func creationUploadServiceUploadFailed(service: CreationUploadService, session: CreationUploadSession, error: ErrorType)
    {
        let data = CreationUploadSessionPublicData(creationUploadSession: session)
        delegate?.creatubblesAPIClientImageUploadFailed(self, uploadSessionData: data, error: APIClient.errorTypeToNSError(error)!)
    }

}
