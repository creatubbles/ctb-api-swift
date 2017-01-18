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

public typealias GroupClosure = (Group?, APIClientError?) -> (Void)
public typealias GroupsClosure = (Array<Group>?, APIClientError?) -> (Void)

public typealias CreationClosure = (Creation?, APIClientError?) -> (Void)
public typealias CreationsClosure = (Array<Creation>?, PagingInfo?, APIClientError?) -> (Void)
public typealias CreationsBatchClosure = (Array<Creation>?, APIClientError?) -> (Void)
public typealias ToybooCreationClosure = (ToybooCreation?, APIClientError?) -> (Void)

public typealias GalleryClosure = (Gallery?, APIClientError?) -> (Void)
public typealias GalleriesClosure = (Array<Gallery>?, PagingInfo?, APIClientError?) -> (Void)
public typealias GalleriesBatchClosure = (Array<Gallery>?, APIClientError?) -> (Void)

public typealias LandingURLClosure = (Array<LandingURL>?, APIClientError?) -> (Void)
public typealias CommentsClosure = (Array<Comment>?, PagingInfo?, APIClientError?) -> (Void)
public typealias ActivitiesClosure = (Array<Activity>?, PagingInfo?, APIClientError?) -> (Void)

public typealias BubbleClousure = (Bubble?, APIClientError?) -> (Void)
public typealias BubblesClousure = (Array<Bubble>?, PagingInfo?, APIClientError?) -> (Void)

public typealias ContentEntryClosure = (ResponseData<ContentEntry>) -> (Void)
public typealias CustomStyleClosure = (CustomStyle?, APIClientError?) -> (Void)
public typealias NotificationsClosure = (Array<Notification>?, _ unreadNotificationsCount: Int?, PagingInfo?, APIClientError?) -> (Void)

public typealias SwitchUserClosure = (String?, APIClientError?) -> (Void)
public typealias UserAccountDetailsClosure = (UserAccountDetails?, APIClientError?) -> (Void)

public typealias PartnerApplicationsClosure = (Array<PartnerApplication>?, APIClientError?) -> (Void)
public typealias PartnerApplicationClosure = (PartnerApplication?, APIClientError?) -> (Void)

public typealias SearchTagsClosure = (Array<SearchTag>?, APIClientError?) -> (Void)

public typealias AvatarSuggestionsClosure = (Array<AvatarSuggestion>?, APIClientError?) -> (Void)

open class ResponseData<T> {
    open let objects: Array<T>?
    open let rejectedObjects: Array<T>?
    open let pagingInfo: PagingInfo?
    open let error: APIClientError?
    
    init(objects: Array<T>?, rejectedObjects: Array<T>?, pagingInfo: PagingInfo?, error: APIClientError?) {
        self.objects = objects
        self.rejectedObjects = rejectedObjects
        self.pagingInfo = pagingInfo
        self.error = error
    }
}

//MARK: - Enums
@objc public enum Gender: Int
{
    case unknown = 0
    case male = 1
    case female = 2
}

@objc public enum SortOrder: Int
{
    case popular
    case recent
}

@objc public enum LandingURLType: Int
{
    case unknown //Read only
    case aboutUs
    case termsOfUse
    case privacyPolicy
    case registration
    case userProfile
    case explore
    case creation
    case forgotPassword
    case uploadGuidelines
    case accountDashboard
}

@objc public enum ApprovalStatus: Int
{
    case unknown
    case approved
    case unapproved
    case rejected
}

@objc public enum NotificationType: Int
{
    case unknown
    case newComment
    case newCreation
    case newGallerySubmission
    case bubbledCreation
    case followedCreator
    case anotherComment
    case newCommentForCreationUsers
    case multipleCreatorsCreated
}

@objc public enum ActivityType: Int
{
    case unknown
    case creationBubbled
    case creationCommented
    case creationPublished
    case galleryBubbled
    case galleryCommented
    case galleryCreationAdded
    case userBubbled
    case userCommented
}

@objc public enum AppScreenshotProvider: Int
{
    case unknown
    case vimeo
    case youtube
}

@objc
public protocol APIClientDelegate
{
    func creatubblesAPIClientNewImageUpload(_ apiClient: APIClient, uploadSessionData: CreationUploadSessionPublicData)
    func creatubblesAPIClientImageUploadFinished(_ apiClient: APIClient, uploadSessionData: CreationUploadSessionPublicData)
    func creatubblesAPIClientImageUploadFailed(_ apiClient: APIClient,  uploadSessionData: CreationUploadSessionPublicData, error: NSError)
    func creatubblesAPIClientImageUploadProcessChanged(_ apiClient: APIClient, uploadSessionData: CreationUploadSessionPublicData, completedUnitCount: Int64, _ totalUnitCount: Int64, _ fractionCompleted: Double)
    func creatubblesAPIClientUserChanged(_ apiClient: APIClient)
}

public protocol Cancelable
{
    func cancel()
}

@objc
open class APIClient: NSObject, CreationUploadServiceDelegate
{
    //MARK: - Internal
    fileprivate let settings: APIClientSettings
    fileprivate let requestSender: RequestSender
    
    fileprivate let creationsDAO: CreationsDAO
    fileprivate let userDAO: UserDAO
    fileprivate let galleryDAO: GalleryDAO
    fileprivate let creationUploadService: CreationUploadService
    fileprivate let bubbleDAO: BubbleDAO
    fileprivate let commentsDAO: CommentsDAO
    fileprivate let contentDAO: ContentDAO
    fileprivate let customStyleDAO: CustomStyleDAO
    fileprivate let notificationDAO: NotificationDAO
    fileprivate let groupDAO: GroupDAO
    fileprivate let userFollowingsDAO: UserFollowingsDAO
    fileprivate let activitiesDAO: ActivitiesDAO
    fileprivate let partnerApplicationDAO: PartnerApplicationDAO
    fileprivate let avatarDAO: AvatarDAO
    fileprivate let searchTagDAO: SearchTagDAO
    
    open weak var delegate: APIClientDelegate?
    
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
        self.groupDAO = GroupDAO(requestSender: requestSender)
        self.userFollowingsDAO = UserFollowingsDAO(requestSender: requestSender)
        self.activitiesDAO = ActivitiesDAO(requestSender: requestSender)
        self.partnerApplicationDAO = PartnerApplicationDAO(requestSender: requestSender)
        self.avatarDAO = AvatarDAO(requestSender: requestSender)
        self.searchTagDAO = SearchTagDAO(requestSender: requestSender)
        
        Logger.setup(logLevel: settings.logLevel)
        super.init()
        self.creationUploadService.delegate = self
    }
    
    //MARK: - Authentication
    
    open var authenticationToken: String? {
        get {
            return requestSender.authenticationToken
        }
        set {
            requestSender.authenticationToken = newValue
        }
    }
    
    @discardableResult
    open func login(username: String, password: String, completion:ErrorClosure?) -> RequestHandler
    {
        
        return requestSender.login(username, password: password)
        {
            [weak self](error) -> (Void) in
            completion?(error)
            if let weakSelf = self , error == nil
            {
                weakSelf.delegate?.creatubblesAPIClientUserChanged(weakSelf)
            }
        }
    }
    
    @discardableResult
    open func authenticate(completion:ErrorClosure?) -> RequestHandler
    {
        
        return requestSender.authenticate {
            (error) -> (Void) in
            completion?(error)
        }
    }
    
    open func logout()
    {
        requestSender.logout()
        delegate?.creatubblesAPIClientUserChanged(self)
    }
    
    open func isLoggedIn() -> Bool
    {
        return requestSender.isLoggedIn()
    }
    
    open func getLandingURL(type: LandingURLType?, completion: LandingURLClosure?) -> RequestHandler
    {
        return userDAO.getLandingURL(type: type, completion: completion)
    }

    open func getLandingURL(creationId: String, completion: LandingURLClosure?) -> RequestHandler
    {
        return userDAO.getLandingURL(creationId: creationId, completion: completion)
    }
    
    //MARK: - Creators managment
    open func getUser(userId: String, completion: UserClosure?) -> RequestHandler
    {
        return userDAO.getUser(userId: userId, completion: completion)
    }
    
    open func getCurrentUser(_ completion: UserClosure?) -> RequestHandler
    {
        return userDAO.getCurrentUser(completion: completion)
    }
    
    open func switchUser(targetUserId: String, accessToken: String, completion: SwitchUserClosure?) -> RequestHandler
    {
        return userDAO.switchUser(targetUserId: targetUserId, accessToken: accessToken) { [weak self] (accessToken, error) in completion?(accessToken, error)
            if let strongSelf = self , error == nil {
                strongSelf.delegate?.creatubblesAPIClientUserChanged(strongSelf)
            }
        }
    }
    
    open func reportUser(userId: String, message: String, completion: ErrorClosure?) -> RequestHandler
    {
        return userDAO.reportUser(userId: userId, message: message, completion: completion)
    }
    
    open func getCreators(userId: String?, query: String? = nil, pagingData: PagingData?, completion: UsersClosure?) -> RequestHandler
    {
        return userDAO.getCreators(userId: userId, query: query, pagingData: pagingData, completion: completion)
    }
    
    open func getCreators(groupId: String, pagingData: PagingData?, completion: UsersClosure?) -> RequestHandler
    {
        return userDAO.getCreators(groupId: groupId, pagingData: pagingData, completion: completion)
    }
    
    open func getUsers(query: String? = nil, pagingData: PagingData?, completion: UsersClosure?) -> RequestHandler
    {
        return userDAO.getUsers(query: query, pagingData: pagingData, completion: completion)
    }
    
    open func getSwitchUsers(_ pagingData: PagingData?, completion: UsersClosure?) -> RequestHandler
    {
        return userDAO.getSwitchUsers(pagingData: pagingData, completion: completion)
    }
    
    open func getManagers(userId: String?, query: String? = nil, pagingData: PagingData?, completion: UsersClosure?) -> RequestHandler
    {
        return userDAO.getManagers(userId: userId, query: query, pagingData: pagingData, completion: completion)
    }

    open func getCreatorsInBatchMode(userId: String?, query: String? = nil, completion: UsersBatchClosure?) -> RequestHandler
    {
        return userDAO.getCreatorsInBatchMode(userId: userId, query: query, completion: completion)
    }
    
    open func getGroupCreatorsInBatchMode(groupId: String, completion: UsersBatchClosure?) -> RequestHandler
    {
        return userDAO.getGroupCreatorsInBatchMode(groupId: groupId, completion: completion)
    }
    
    open func getManagersInBatchMode(userId: String?, query: String? = nil, completion: UsersBatchClosure?) -> RequestHandler
    {
        return userDAO.getManagersInBatchMode(userId: userId, query: query, completion: completion)
    }
    
    open func newCreator(data creatorData: NewCreatorData,completion: UserClosure?) -> RequestHandler
    {
        return userDAO.newCreator(data: creatorData, completion: completion)
    }
    
    open func editProfile(userId identifier: String, data: EditProfileData, completion: ErrorClosure?) -> RequestHandler
    {
        return userDAO.editProfile(identifier: identifier, data: data, completion: completion)
    }
    
    open func createMultipleCreators(data: CreateMultipleCreatorsData, completion: ErrorClosure?) -> RequestHandler
    {
        return userDAO.createMultipleCreators(data, completion: completion)
    }
    
    open func getMyConnections(query: String?, pagingData: PagingData?, completion: UsersClosure?) -> RequestHandler
    {
        return userDAO.getMyConnections(pagingData: pagingData, query: query, completion: completion)
    }
    
    open func getOtherUsersMyConnections(userId: String, query: String?, pagingData: PagingData?, completion: UsersClosure?) -> RequestHandler
    {
        return userDAO.getOtherUsersMyConnections(userId: userId, query: query, pagingData: pagingData, completion: completion)
    }
    
    open func getUsersFollowedByAUser(userId: String, pagingData: PagingData?, completion: UsersClosure?) -> RequestHandler
    {
        return userDAO.getUsersFollowedByAUser(userId, pagingData: pagingData, completion: completion)
    }
    
    open func getUserAccountData(userId: String, completion: UserAccountDetailsClosure?) -> RequestHandler
    {
        return userDAO.getUserAccountData(userId: userId, completion: completion)
    }
    
    

    //MARK: - Gallery managment
    open func getGallery(galleryId: String, completion: GalleryClosure?) -> RequestHandler
    {
        return galleryDAO.getGallery(galleryIdentifier: galleryId, completion: completion)
    }
    
    open func getGalleries(creationId: String, pagingData: PagingData?, sort: SortOrder?, completion: GalleriesClosure?) -> RequestHandler
    {
        return galleryDAO.getGalleries(creationIdentifier: creationId, pagingData: pagingData, sort: sort, completion: completion)
    }

    open func getGalleries(userId: String?, query: String? = nil, pagingData: PagingData?, sort: SortOrder?, completion: GalleriesClosure?) -> RequestHandler
    {
        return galleryDAO.getGalleries(userIdentifier: userId, query: query,pagingData: pagingData, sort: sort, completion: completion)
    }
    
    open func getGalleriesInBatchMode(userId: String?, query: String? = nil, sort: SortOrder?, completion: GalleriesBatchClosure?) -> RequestHandler
    {
        return galleryDAO.getGalleriesInBatchMode(userIdentifier: userId, query:query, sort: sort, completion: completion)
    }
    
    open func getMyGalleries(_ pagingData: PagingData?, completion: GalleriesClosure?) -> RequestHandler
    {
        return galleryDAO.getMyGalleries(pagingData, completion: completion)
    }
    
    open func getMyOwnedGalleries(_ pagingData: PagingData?, completion: GalleriesClosure?) -> RequestHandler
    {
        return galleryDAO.getMyOwnedGalleries(pagingData, completion: completion)
    }
    
    open func getMySharedGalleries(_ pagingData: PagingData?, completion: GalleriesClosure?) -> RequestHandler
    {
        return galleryDAO.getMySharedGalleries(pagingData, completion: completion)
    }
    
    open func getMyFavoriteGalleries(_ pagingData: PagingData?, completion: GalleriesClosure?) -> RequestHandler
    {
        return galleryDAO.getMyFavoriteGalleries(pagingData, completion: completion)
    }
    
    open func getFeaturedGalleries(_ pagingData: PagingData?, completion: GalleriesClosure?) -> RequestHandler
    {
        return galleryDAO.getFeaturedGalleries(pagingData, completion: completion)
    }
    
    open func getMyGalleriesInBatchMode(_ completion: GalleriesBatchClosure?) -> RequestHandler
    {
        return galleryDAO.getMyGalleriesInBatchMode(completion)
    }
    
    open func getOwnedGalleriesInBatchMode(_ completion: GalleriesBatchClosure?) -> RequestHandler
    {
        return galleryDAO.getMyOwnedGalleriesInBatchMode(completion)
    }
    
    open func getSharedGalleriesInBatchMode(_ completion: GalleriesBatchClosure?) -> RequestHandler
    {
        return galleryDAO.getMySharedGalleriesInBatchMode(completion)
    }
    
    open func getFavoriteGalleriesInBatchMode(_ completion: GalleriesBatchClosure?) -> RequestHandler
    {
        return galleryDAO.getFavoriteGalleriesInBatchMode(completion)
    }
    
    open func getFeaturedGalleriesInBatchMode(_ completion: GalleriesBatchClosure?) -> RequestHandler
    {
        return galleryDAO.getFeaturedGalleriesInBatchMode(completion)
    }
    
    open func newGallery(data galleryData: NewGalleryData, completion: GalleryClosure?) -> RequestHandler
    {
        return galleryDAO.newGallery(data: galleryData, completion: completion)
    }
    
    open func updateGallery(data: UpdateGalleryData, completion: ErrorClosure?) -> RequestHandler
    {
        return galleryDAO.updateGallery(data: data, completion: completion)
    }
    
    open func reportGallery(galleryId: String, message: String, completion: ErrorClosure?) -> RequestHandler
    {
        return galleryDAO.reportGallery(galleryIdentifier: galleryId, message: message, completion: completion)
    }
    
    open func submitCreationToGallery(galleryId: String, creationId: String, completion: @escaping ErrorClosure) -> RequestHandler
    {
        return galleryDAO.submitCreationToGallery(galleryIdentifier: galleryId, creationId: creationId, completion: completion)
    }
    
    open func submitCreationToGalleries(creationId: String, galleryIdentifiers: Array<String>, completion: ErrorClosure?) -> RequestHandler
    {
        return galleryDAO.submitCreationToGalleries(creationId: creationId, galleryIdentifiers: galleryIdentifiers, completion: completion)
    }

    //MARK: - Creation managment
    open func getCreation(creationId: String, completion: CreationClosure?) -> RequestHandler
    {
        return creationsDAO.getCreation(creationIdentifier: creationId, completion: completion)
    }
    
    open func reportCreation(creationId: String, message: String, completion: ErrorClosure?) -> RequestHandler
    {
        return creationsDAO.reportCreation(creationIdentifier: creationId, message: message, completion: completion)
    }
    
    open func getCreations(galleryId: String?, userId: String?, keyword: String?, pagingData: PagingData?, sortOrder: SortOrder?, partnerApplicationId: String?, onlyPublic: Bool,  completion: CreationsClosure?) -> RequestHandler
    {
        return creationsDAO.getCreations(galleryIdentifier: galleryId, userId: userId, keyword: keyword, pagingData: pagingData, sortOrder: sortOrder, partnerApplicationId: partnerApplicationId, onlyPublic: onlyPublic, completion: completion)
    }
    
    open func getRecomendedCreationsByUser(userId: String, pagingData: PagingData?, completon: CreationsClosure?) -> RequestHandler
    {
        return creationsDAO.getRecomendedCreationsByUser(userIdentifier: userId, pagingData: pagingData, completon: completon)
    }
    
    open func getRecomendedCreationsByCreation(creationId: String, pagingData: PagingData?, completon: CreationsClosure?) -> RequestHandler
    {
        return creationsDAO.getRecomendedCreationsByCreation(creationIdentifier: creationId, pagingData: pagingData, completon: completon)
    }
    
    open func editCreation(creationId: String, data: EditCreationData, completion: ErrorClosure?) -> RequestHandler
    {
        return creationsDAO.editCreation(creationIdentifier: creationId, data: data, completion: completion)
    }
    
    open func getCreationsInBatchMode(galleryId: String?, userId: String?, keyword: String?, partnerApplicationId: String?, sortOrder: SortOrder?, onlyPublic: Bool, completion: CreationsBatchClosure?) -> RequestHandler
    {
        return creationsDAO.getCreationsInBatchMode(galleryIdentifier: galleryId, userId: userId, keyword: keyword, sortOrder: sortOrder, partnerApplicationId: partnerApplicationId, onlyPublic: onlyPublic, completion: completion)
    }

    open func removeCreation(creationId: String, completion: ErrorClosure?) -> RequestHandler
    {
        return creationsDAO.removeCreation(creationIdentifier: creationId, completion: completion)
    }
    
    open func getToybooCreation(creationId: String, completion: ToybooCreationClosure?) -> RequestHandler
    {
        return creationsDAO.getToybooCreation(creationIdentifier: creationId, completion: completion)
    }
    
    //MARK: - Upload Sessions
    open func getAllActiveUploadSessionPublicData() -> Array<CreationUploadSessionPublicData>
    {
        return creationUploadService.getAllActiveUploadSessionsPublicData()
    }
    
    open func getAllFinishedUploadSessionPublicData() -> Array<CreationUploadSessionPublicData>
    {
        return creationUploadService.getAllFinishedUploadSessionPublicData()
    }
    
    open func getAllNotFinishedUploadSessionsPublicData() ->  Array<CreationUploadSessionPublicData>
    {
        return creationUploadService.getAllNotFinishedUploadSessionsPublicData()
    }    
    
    open func startAllNotFinishedUploadSessions(_ completion: CreationClosure?)
    {
        creationUploadService.startAllNotFinishedUploadSessions(completion)
    }
    
    open func cancelUploadSession(sessionId: String)
    {
        creationUploadService.removeUploadSession(sessionIdentifier: sessionId)
    }
    
    open func removeAllUploadSessions()
    {
        creationUploadService.removeAllUploadSessions()
    }
    
    open func startUploadSession(sessionId: String)
    {
        creationUploadService.startUploadSession(sessionIdentifier: sessionId)
    }
    
    //MARK: - Creation flow
    open func newCreation(data creationData: NewCreationData, completion: CreationClosure?) -> CreationUploadSessionPublicData?
    {
        return creationUploadService.uploadCreation(data: creationData, completion: completion)
    }
    
    //MARK: - Background session
    open var backgroundCompletionHandler: (() -> Void)?
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
    open func getBubbles(creationId identifier: String, pagingData: PagingData?, completion: BubblesClousure?) -> RequestHandler
    {
        return bubbleDAO.getBubbles(creationIdentifier: identifier, pagingData: pagingData, completion: completion)
    }
    
    open func getBubbles(userId identifier: String, pagingData: PagingData?, completion: @escaping BubblesClousure) -> RequestHandler
    {
        return bubbleDAO.getBubbles(userIdentifier: identifier, pagingData: pagingData, completion: completion)
    }
    
    open func getBubbles(galleryId identifier: String, pagingData: PagingData?, completion: @escaping BubblesClousure) -> RequestHandler
    {
        return bubbleDAO.getBubbles(galleryIdentifier: identifier, pagingData: pagingData, completion: completion)
    }
    
    open func newBubble(data: NewBubbleData, completion: BubbleClousure?) -> RequestHandler
    {
        return bubbleDAO.newBubble(data: data, completion: completion)
    }
    
    open func updateBubble(data: UpdateBubbleData, completion: BubbleClousure?) -> RequestHandler
    {
        return bubbleDAO.updateBubble(data: data, completion: completion)
    }
    
    open func deleteBubble(bubbleId: String, completion: ErrorClosure?) -> RequestHandler
    {
        return bubbleDAO.deleteBubble(bubbleIdentifier: bubbleId, completion: completion)
    }
    //MARK: - Groups
    
    open func fetchGroup(groupId identifier: String, completion: GroupClosure?) -> RequestHandler
    {
        return groupDAO.fetchGroup(groupIdentifier: identifier, completion: completion)
    }
    
    open func fetchGroups(_ completion: GroupsClosure?) -> RequestHandler
    {
        return groupDAO.fetchGroups(completion)
    }
    
    open func newGroup(data: NewGroupData, completion: GroupClosure?) -> RequestHandler
    {
        return groupDAO.newGroup(newGroupData: data, completion: completion)
    }
    
    open func editGroup(groupId identifier: String, data: EditGroupData, completion: ErrorClosure?) -> RequestHandler
    {
        return groupDAO.editGroup(groupIdentifier: identifier, data: data, completion: completion)
    }
    
    open func deleteGroup(groupId identifier: String, completion: ErrorClosure?) -> RequestHandler
    {
        return groupDAO.deleteGroup(groupIdentifier: identifier, completion: completion)        
    }

    //MARK: - Comments
    open func addComment(data: NewCommentData, completion: ErrorClosure?) -> RequestHandler
    {
        return commentsDAO.addComment(commendData: data, completion: completion)
    }
    
    open func declineComment(commentId: String, completion: ErrorClosure?) -> RequestHandler
    {
        return commentsDAO.declineComment(commentIdentifier: commentId, completion: completion)
    }
    
    open func reportComment(commentId: String, message: String, completion: ErrorClosure?) -> RequestHandler
    {
        return commentsDAO.reportComment(commentIdentifier: commentId, message: message, completion: completion)
    }
    
    open func getComments(creationId: String, pagingData: PagingData?, completion: CommentsClosure?) -> RequestHandler
    {
        return commentsDAO.getComments(creationIdentifier: creationId, pagingData: pagingData, completion: completion)
    }
    
    open func getComments(userId: String, pagingData: PagingData?, completion: CommentsClosure?) -> RequestHandler
    {
        return commentsDAO.getComments(userIdentifier: userId, pagingData: pagingData, completion: completion)
    }
    
    open func getComments(galleryId: String, pagingData: PagingData?, completion: CommentsClosure?) -> RequestHandler
    {
        return commentsDAO.getComments(galleryIdentifier: galleryId, pagingData: pagingData, completion: completion)
    }
    
    //MARK: - Content
    open func getTrendingContent(pagingData: PagingData?, completion: ContentEntryClosure?) -> RequestHandler
    {
        return contentDAO.getTrendingContent(pagingData: pagingData, completion: completion)
    }
    
    open func getRecentContent(pagingData: PagingData?, completion: ContentEntryClosure?) -> RequestHandler
    {
        return contentDAO.getRecentContent(pagingData: pagingData, completion: completion)
    }
    
    open func getBubbledContent(userId: String, pagingData: PagingData?, completion: ContentEntryClosure?) -> RequestHandler
    {
        return contentDAO.getUserBubbledContent(userIdentifier: userId, pagingData: pagingData, completion: completion)
    }
    
    open func getMyConnectionsContent(pagingData: PagingData?, completion: ContentEntryClosure?) -> RequestHandler
    {
        return contentDAO.getMyConnectionsContent(pagingData: pagingData, completion: completion)
    }
    
    open func getContentsByAUser(userId: String, pagingData: PagingData?, completion: ContentEntryClosure?) -> RequestHandler
    {
        return contentDAO.getContentsByAUser(userIdentfier: userId, pagingData: pagingData, completion: completion)
    }
    
    open func getFollowedContents(_ pagingData: PagingData?, completion: ContentEntryClosure?) -> RequestHandler
    {
        return contentDAO.getFollowedContents(pagingData, completion: completion)
    }
    
    open func getSearchedContents(query: String, pagingData: PagingData?, completion: ContentEntryClosure?) -> RequestHandler
    {
        return contentDAO.getSearchedContents(query: query, pagingData: pagingData, completion: completion)
    }
    
    //MARK: - CustomStyle
    open func fetchCustomStyleForUser(userId identifier: String, completion: CustomStyleClosure?) -> RequestHandler
    {
        return customStyleDAO.fetchCustomStyleForUser(userIdentifier: identifier, completion: completion)
    }
    
    open func editCustomStyleForUser(userId identifier: String, withData data: CustomStyleEditData, completion: CustomStyleClosure?) -> RequestHandler
    {
        return customStyleDAO.editCustomStyleForUser(userIdentifier: identifier, withData: data, completion: completion)
    }
    
    // MARK: - Activities
    
    open func getActivities(pagingData: PagingData?, completion: ActivitiesClosure?) -> RequestHandler
    {
        return activitiesDAO.getActivities(pagingData, completion: completion)
    }
    
    //MARK: - Notifications
    
    open func getNotifications(pagingData: PagingData?, completion: NotificationsClosure?) -> RequestHandler
    {        
        return notificationDAO.getNotifications(pagingData: pagingData, completion: completion)
    }
    
    open func markNotificationAsRead(notificationId: String, completion: ErrorClosure?) -> RequestHandler
    {
        return notificationDAO.markNotificationAsRead(notificationIdentifier: notificationId, completion: completion)
    }
    
    open func trackWhenNotificationsWereViewed(completion: ErrorClosure?) -> RequestHandler
    {
        return notificationDAO.trackWhenNotificationsWereViewed(completion: completion)
    }

    //MARK: - User Followings
    open func createUserFollowing(userId: String, completion: ErrorClosure?) -> RequestHandler
    {
        return userFollowingsDAO.createAUserFollowing(userId, completion: completion)
    }
    
    open func deleteAUserFollowing(userId: String, completion: ErrorClosure?) -> RequestHandler
    {
        return userFollowingsDAO.deleteAUserFollowing(userId, completion: completion)
    }
    
    //MARK: - Partner Applications
    open func getPartnerApplication(_ id: String, completion: PartnerApplicationClosure?) -> RequestHandler
    {
        return partnerApplicationDAO.getPartnerApplication(id, completion: completion)
    }
    
    open func searchPartnerApplications(_ query: String, completion: PartnerApplicationsClosure?) -> RequestHandler
    {
        return partnerApplicationDAO.searchPartnerApplications(query, completion: completion)
    }
    
    //MARK: - Avatar
    
    open func getSuggestedAvatars(completion: AvatarSuggestionsClosure?) -> RequestHandler
    {
        return avatarDAO.getSuggestedAvatars(completion: completion)
    }
    
    open func updateUserAvatar(userId: String, data: UpdateAvatarData, completion: ErrorClosure?) -> RequestHandler
    {
        return avatarDAO.updateUserAvatar(userId: userId, data: data, completion: completion)
    }
    
    //MARK: - SearchTags
    open func getSearchTags(completion: SearchTagsClosure?) -> RequestHandler
    {
        return searchTagDAO.fetchSearchTags(completion: completion)
    }
    
    //MARK: - Log listener
    open func addLoggerListnerer(_ listener: LogListener)
    {
        Logger.addListener(listener: listener)
    }
    
    //MARK: - Delegate
    func creationUploadService(_ sender: CreationUploadService, newSessionAdded session: CreationUploadSession)
    {
        let data = CreationUploadSessionPublicData(creationUploadSession: session)
        delegate?.creatubblesAPIClientNewImageUpload(self, uploadSessionData: data)                
    }
    
    func creationUploadService(_ sender: CreationUploadService, uploadFinished session: CreationUploadSession)
    {
        let data = CreationUploadSessionPublicData(creationUploadSession: session)
        delegate?.creatubblesAPIClientImageUploadFinished(self, uploadSessionData: data)
    }
    
    func creationUploadService(_ sender: CreationUploadService, progressChanged session: CreationUploadSession, completedUnitCount: Int64, totalUnitcount: Int64, fractionCompleted: Double)
    {
        let data = CreationUploadSessionPublicData(creationUploadSession: session)
        delegate?.creatubblesAPIClientImageUploadProcessChanged(self, uploadSessionData: data, completedUnitCount: completedUnitCount, totalUnitcount, fractionCompleted)
    }
    
    func creationUploadService(_ sender: CreationUploadService, uploadFailed session: CreationUploadSession, withError error: Error)
    {
        let data = CreationUploadSessionPublicData(creationUploadSession: session)
        delegate?.creatubblesAPIClientImageUploadFailed(self, uploadSessionData: data, error: APIClient.errorTypeToNSError(error)!)
    }
}
