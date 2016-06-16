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
public typealias CommentsClosure = (Array<Comment>?, PagingInfo?, APIClientError?) -> (Void)

public typealias BubbleClousure = (Bubble?, APIClientError?) -> (Void)
public typealias BubblesClousure = (Array<Bubble>?, PagingInfo?, APIClientError?) -> (Void)

public typealias ContentEntryClosure = (Array<ContentEntry>?, PagingInfo?, APIClientError?) -> (Void)
public typealias CustomStyleClosure = (CustomStyle?, APIClientError?) -> (Void)
public typealias NotificationsClosure = (Array<Notification>?, PagingInfo?, APIClientError?) -> (Void)

//MARK: - Enums
@objc public enum Gender: Int
{
    case Unknown = 0
    case Male = 1
    case Female = 2
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

@objc public enum ApprovalStatus: Int
{
    case Unknown
    case Approved
    case Unapproved
    case Rejected
}

@objc public enum NotificationType: Int
{
    case Unknown
    case NewComment
    case NewCreation
    case NewGallerySubmission
    case BubbledCreation
    case FollowedCreator
    case AnotherComment
    case NewCommentForCreationUsers
}

@objc
public protocol APIClientDelegate
{
    func creatubblesAPIClientImageUploadFinished(apiClient: APIClient, uploadSessionData: CreationUploadSessionPublicData)
    func creatubblesAPIClientImageUploadFailed(apiClient: APIClient,  uploadSessionData: CreationUploadSessionPublicData, error: NSError)
    func creatubblesAPIClientImageUploadProcessChanged(apiClient: APIClient, uploadSessionData: CreationUploadSessionPublicData, bytesUploaded: Int, bytesExpectedToUpload: Int)
    func creatubblesAPIClientUserChanged(apiClient: APIClient)
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
    private let bubbleDAO: BubbleDAO
    private let commentsDAO: CommentsDAO
    private let contentDAO: ContentDAO
    private let customStyleDAO: CustomStyleDAO
    private let notificationDAO: NotificationDAO
    
    public weak var delegate: APIClientDelegate?
    
    public init(settings: APIClientSettings)
    {
        self.settings = settings
        self.requestSender = RequestSender(settings: settings)
        self.creationsDAO = CreationsDAO(requestSender: requestSender)
        self.userDAO = UserDAO(requestSender: requestSender)
        self.galleryDAO = GalleryDAO(requestSender: requestSender)
        self.creationUploadService = CreationUploadService(requestSender: requestSender)
        self.bubbleDAO = BubbleDAO(requestSender: requestSender)
        self.commentsDAO = CommentsDAO(requestSender: requestSender)
        self.contentDAO = ContentDAO(requestSender: requestSender)
        self.customStyleDAO = CustomStyleDAO(requestSender: requestSender)
        self.notificationDAO = NotificationDAO(requestSender: requestSender)
        
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
        
        return requestSender.login(username, password: password)
        {
            [weak self](error) -> (Void) in
            completion?(error)
            if let weakSelf = self where error == nil
            {
                weakSelf.delegate?.creatubblesAPIClientUserChanged(weakSelf)
            }
        }
    }
    
    public func logout()
    {
        requestSender.logout()
        delegate?.creatubblesAPIClientUserChanged(self)
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
    
    public func editProfile(identifier: String, data: EditProfileData, completion: ErrorClosure?) -> RequestHandler
    {
        return userDAO.editProfile(identifier, data: data, completion: completion)
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
    
    public func submitCreationToGallery(galleryId: String, creationId: String, completion: ErrorClosure) -> RequestHandler
    {
        return galleryDAO.submitCreationToGallery(galleryId, creationId: creationId, completion: completion)
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
    
    public func getRecomendedCreationsByUser(userId: String, pagingData: PagingData?, completon: CreationsClosure?) -> RequestHandler
    {
        return creationsDAO.getRecomendedCreationsByUser(userId, pagingData: pagingData, completon: completon)
    }
    
    public func getRecomendedCreationsByCreation(creationId: String, pagingData: PagingData?, completon: CreationsClosure?) -> RequestHandler
    {
        return creationsDAO.getRecomendedCreationsByCreation(creationId, pagingData: pagingData, completon: completon)
    }
    
    public func editCreation(creationId: String, data: EditCreationData, completion: ErrorClosure?) -> RequestHandler
    {
        return creationsDAO.editCreation(creationId, data: data, completion: completion)
    }
    
    //MARK: - Upload Sessions
    public func getAllActiveUploadSessionPublicData() -> Array<CreationUploadSessionPublicData>
    {
        return creationUploadService.getAllActiveUploadSessionsPublicData()
    }
    
    public func getAllFinishedUploadSessionPublicData() -> Array<CreationUploadSessionPublicData>
    {
        return creationUploadService.getAllFinishedUploadSessionPublicData()
    }
    
    public func startAllNotFinishedUploadSessions(completion: CreationClosure?)
    {
        creationUploadService.startAllNotFinishedUploadSessions(completion)
    }
    
    public func cancelUploadSession(sessionId: String)
    {
        creationUploadService.removeUploadSession(sessionId)
    }
    
    public func removeAllUploadSessions()
    {
        creationUploadService.removeAllUploadSessions()
    }
    
    //MARK: - Creation flow
    public func newCreation(creationData: NewCreationData, completion: CreationClosure?) -> CreationUploadSessionPublicData
    {
        return creationUploadService.uploadCreation(creationData, completion: completion)
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
    
    //MARK: - Bubbles
    public func getBubblesForCreationWithIdentifier(identifier: String, pagingData: PagingData?, completion: BubblesClousure?) -> RequestHandler
    {
        return bubbleDAO.getBubblesForCreationWithIdentifier(identifier, pagingData: pagingData, completion: completion)
    }
    
    public func getBubblesForUserWithIdentifier(identifier: String, pagingData: PagingData?, completion: BubblesClousure) -> RequestHandler
    {
        return bubbleDAO.getBubblesForUserWithIdentifier(identifier, pagingData: pagingData, completion: completion)
    }
    
    public func getBubblesForGalleryWithIdentifier(identifier: String, pagingData: PagingData?, completion: BubblesClousure) -> RequestHandler
    {
        return bubbleDAO.getBubblesForGalleryWithIdentifier(identifier, pagingData: pagingData, completion: completion)
    }
    
    public func newBubble(data: NewBubbleData, completion: BubbleClousure?) -> RequestHandler
    {
        return bubbleDAO.newBubble(data, completion: completion)
    }
    
    public func updateBubble(data: UpdateBubbleData, completion: BubbleClousure?) -> RequestHandler
    {
        return bubbleDAO.updateBubble(data, completion: completion)
    }
    
    public func deleteBubble(bubbleId: String, completion: ErrorClosure?) -> RequestHandler
    {
        return bubbleDAO.deleteBubble(bubbleId, completion: completion)
    }

    //MARK: - Comments
    public func addComment(data: NewCommentData, completion: ErrorClosure?) -> RequestHandler
    {
        return commentsDAO.addComment(data, completion: completion)
    }
    
    public func getCommentsForCreationWithIdentifier(identifier: String, pagingData: PagingData?, completion: CommentsClosure?) -> RequestHandler
    {
        return commentsDAO.getCommentsForCreationWithIdentifier(identifier, pagingData: pagingData, completion: completion)
    }
    
    public func getCommentsForUserWithIdentifier(identifier: String, pagingData: PagingData?, completion: CommentsClosure?) -> RequestHandler
    {
        return commentsDAO.getCommentsForUserWithIdentifier(identifier, pagingData: pagingData, completion: completion)
    }
    
    public func getCommentsForGalleryWithIdentifier(identifier: String, pagingData: PagingData?, completion: CommentsClosure?) -> RequestHandler
    {
        return commentsDAO.getCommentsForGalleryWithIdentifier(identifier, pagingData: pagingData, completion: completion)
    }
    
    //MARK: - Content
    public func getTrendingContent(pagingData: PagingData?, completion: ContentEntryClosure?) -> RequestHandler
    {
        return contentDAO.getTrendingContent(pagingData, completion: completion)
    }
    
    public func getRecentContent(pagingData: PagingData?, completion: ContentEntryClosure?) -> RequestHandler
    {
        return contentDAO.getRecentContent(pagingData, completion: completion)
    }
    
    //MARK: - CustomStyle
    public func fetchCustomStyleForUserWithIdentifier(identifier: String, completion: CustomStyleClosure?) -> RequestHandler
    {
        return customStyleDAO.fetchCustomStyleForUserWithIdentifier(identifier, completion: completion)
    }
    
    public func editCustomStyleForUserWithIdentifier(identifier: String, withData data: CustomStyleEditData, completion: CustomStyleClosure?) -> RequestHandler
    {
        return customStyleDAO.editCustomStyleForUserWithIdentifier(identifier, withData: data, completion: completion)        
    }
    
    //MARK: - Notifications
    
    public func getNotifications(pagingData: PagingData?, completion: NotificationsClosure?) -> RequestHandler
    {        
        return notificationDAO.getNotifications(pagingData, completion: completion)
    }
    
    public func markNotificationAsRead(identifier: String, completion: ErrorClosure?) -> RequestHandler
    {
        return notificationDAO.markNotificationAsRead(identifier, completion: completion)
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
