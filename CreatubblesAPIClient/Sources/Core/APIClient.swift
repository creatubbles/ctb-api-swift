//
//  CreatubblesAPIClient.swift
//  CreatubblesAPIClient
//
//  Copyright (c) 2017 Creatubbles Pte. Ltd.
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

// MARK: - Typealiases
public typealias ErrorClosure = (APIClientError?) -> (Void)

public typealias UserClosure = (User?, APIClientError?) -> (Void)
public typealias UsersClosure = (Array<User>?, PagingInfo?, APIClientError?) -> (Void)
public typealias UsersBatchClosure = (Array<User>?, APIClientError?) -> (Void)

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
public typealias NotificationsClosure = (ResponseData<Notification>?, _ newNotificationsCount: Int?, _ unreadNotificationsCount: Int?, _ hasUnreadNotifications: Bool?) -> (Void)

public typealias SwitchUserClosure = (String?, APIClientError?) -> (Void)
public typealias UserAccountDetailsClosure = (UserAccountDetails?, APIClientError?) -> (Void)

public typealias PartnerApplicationsClosure = (Array<PartnerApplication>?, APIClientError?) -> (Void)
public typealias PartnerApplicationClosure = (PartnerApplication?, APIClientError?) -> (Void)

public typealias SearchTagsClosure = (Array<SearchTag>?, PagingInfo?, APIClientError?) -> (Void)
public typealias HashtagsClosure = (Array<Hashtag>?, PagingInfo?, APIClientError?) -> (Void)
public typealias HashtagClosure = (Hashtag?, APIClientError?) -> (Void)

public typealias AvatarSuggestionsClosure = (Array<AvatarSuggestion>?, APIClientError?) -> (Void)

open class ResponseData<T> {
    open let objects: Array<T>?
    open let rejectedObjects: Array<T>?
    open let pagingInfo: PagingInfo?
    open let error: APIClientError?

    public init(objects: Array<T>?, rejectedObjects: Array<T>?, pagingInfo: PagingInfo?, error: APIClientError?) {
        self.objects = objects
        self.rejectedObjects = rejectedObjects
        self.pagingInfo = pagingInfo
        self.error = error
    }
}

// MARK: - Enums
@objc public enum Gender: Int {
    case unknown = 0
    case male = 1
    case female = 2
}

@objc public enum SortOrder: Int {
    case popular
    case recent
}

@objc public enum LandingURLType: Int {
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

@objc public enum ApprovalStatus: Int {
    case unknown
    case approved
    case unapproved
    case rejected
}

@objc public enum NotificationType: Int {
    case unknown
    case newComment
    case newCreation
    case newGallerySubmission
    case bubbledCreation
    case followedCreator
    case anotherComment
    case newCommentForCreationUsers
    case multipleCreatorsCreated
    case receivedFavorite
    case translationTip
    case customizeTip
    case galleriesTip
    case bubblesTip
    case uploadTip
}

@objc public enum ActivityType: Int {
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

@objc public enum AppScreenshotProvider: Int {
    case unknown
    case vimeo
    case youtube
}

@objc
public protocol APIClientDelegate {
    func creatubblesAPIClientNewImageUpload(_ apiClient: APIClient, uploadSessionData: CreationUploadSessionPublicData)
    func creatubblesAPIClientImageUploadFinished(_ apiClient: APIClient, uploadSessionData: CreationUploadSessionPublicData)
    func creatubblesAPIClientImageUploadFailed(_ apiClient: APIClient, uploadSessionData: CreationUploadSessionPublicData, error: NSError)
    func creatubblesAPIClientImageUploadProcessChanged(_ apiClient: APIClient, uploadSessionData: CreationUploadSessionPublicData, completedUnitCount: Int64, _ totalUnitCount: Int64, _ fractionCompleted: Double)
    func creatubblesAPIClientUserChanged(_ apiClient: APIClient)
}

public protocol Cancelable {
    func cancel()
}

@objc
open class APIClient: NSObject, CreationUploadServiceDelegate {
    // MARK: - Internal
    fileprivate let settings: APIClientSettings
    fileprivate let creationUploadService: CreationUploadService

    public let requestSender: RequestSender
    public let daoAssembly: DAOAssembly
    open weak var delegate: APIClientDelegate?

    public init(settings: APIClientSettings) {
        self.settings = settings
        self.requestSender = RequestSender(settings: settings)
        let dependencies = DAODependencies(requestSender: requestSender)
        self.daoAssembly = DAOAssembly(dependencies: dependencies)
        self.creationUploadService = CreationUploadService(requestSender: requestSender)

        self.daoAssembly.register(dao: CreationsDAO(dependencies: dependencies))
        self.daoAssembly.register(dao: UserDAO(dependencies: dependencies))
        self.daoAssembly.register(dao: GalleryDAO(dependencies: dependencies))
        self.daoAssembly.register(dao: BubbleDAO(dependencies: dependencies))
        self.daoAssembly.register(dao: CommentsDAO(dependencies: dependencies))
        self.daoAssembly.register(dao: CustomStyleDAO(dependencies: dependencies))
        self.daoAssembly.register(dao: NotificationDAO(dependencies: dependencies))
        self.daoAssembly.register(dao: ContentDAO(dependencies: dependencies))
        self.daoAssembly.register(dao: GroupDAO(dependencies: dependencies))
        self.daoAssembly.register(dao: UserFollowingsDAO(dependencies: dependencies))
        self.daoAssembly.register(dao: ActivitiesDAO(dependencies: dependencies))
        self.daoAssembly.register(dao: PartnerApplicationDAO(dependencies: dependencies))
        self.daoAssembly.register(dao: AvatarDAO(dependencies: dependencies))
        self.daoAssembly.register(dao: SearchTagDAO(dependencies: dependencies))
        self.daoAssembly.register(dao: HashtagDAO(dependencies: dependencies))
        self.daoAssembly.register(dao: DatabaseDAO())

        Logger.setup(logLevel: settings.logLevel)
        super.init()
        self.creationUploadService.delegate = self
    }

    // MARK: - Authentication

    open var authenticationToken: String? {
        get {
            return requestSender.authenticationToken
        }
        set {
            requestSender.authenticationToken = newValue
        }
    }

    @discardableResult
    open func login(username: String, password: String, completion: ErrorClosure?) -> RequestHandler {

        return requestSender.login(username, password: password) {
            [weak self](error) -> (Void) in
            completion?(error)
            if let weakSelf = self, error == nil {
                weakSelf.delegate?.creatubblesAPIClientUserChanged(weakSelf)
            }
        }
    }

    @discardableResult
    open func authenticate(completion: ErrorClosure?) -> RequestHandler {

        return requestSender.authenticate {
            (error) -> (Void) in
            completion?(error)
        }
    }

    open func logout() {
        requestSender.logout()
        delegate?.creatubblesAPIClientUserChanged(self)
    }

    open func isLoggedIn() -> Bool {
        return requestSender.isLoggedIn()
    }

    open func getLandingURL(type: LandingURLType?, completion: LandingURLClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserDAO.self).getLandingURL(type: type, completion: completion)
    }

    open func getLandingURL(creationId: String, completion: LandingURLClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserDAO.self).getLandingURL(creationId: creationId, completion: completion)
    }

    // MARK: - Creators managment
    open func getUser(userId: String, completion: UserClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserDAO.self).getUser(userId: userId, completion: completion)
    }

    open func getCurrentUser(_ completion: UserClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserDAO.self).getCurrentUser(completion: completion)
    }

    open func switchUser(targetUserId: String, accessToken: String, completion: SwitchUserClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserDAO.self).switchUser(targetUserId: targetUserId, accessToken: accessToken) { [weak self] (accessToken, error) in completion?(accessToken, error)
            if let strongSelf = self, error == nil {
                strongSelf.delegate?.creatubblesAPIClientUserChanged(strongSelf)
            }
        }
    }

    open func reportUser(userId: String, message: String, completion: ErrorClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserDAO.self).reportUser(userId: userId, message: message, completion: completion)
    }

    open func getCreators(userId: String?, query: String? = nil, pagingData: PagingData?, completion: UsersClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserDAO.self).getCreators(userId: userId, query: query, pagingData: pagingData, completion: completion)
    }

    open func getCreators(groupId: String, pagingData: PagingData?, completion: UsersClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserDAO.self).getCreators(groupId: groupId, pagingData: pagingData, completion: completion)
    }

    open func getUsers(query: String? = nil, pagingData: PagingData?, completion: UsersClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserDAO.self).getUsers(query: query, pagingData: pagingData, completion: completion)
    }

    open func getSwitchUsers(query: String? = nil, pagingData: PagingData?, completion: UsersClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserDAO.self).getSwitchUsers(query: query, pagingData: pagingData, completion: completion)
    }

    open func getManagers(userId: String?, query: String? = nil, pagingData: PagingData?, completion: UsersClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserDAO.self).getManagers(userId: userId, query: query, pagingData: pagingData, completion: completion)
    }

    open func getCreatorsInBatchMode(userId: String?, query: String? = nil, completion: UsersBatchClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserDAO.self).getCreatorsInBatchMode(userId: userId, query: query, completion: completion)
    }

    open func getGroupCreatorsInBatchMode(groupId: String, completion: UsersBatchClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserDAO.self).getGroupCreatorsInBatchMode(groupId: groupId, completion: completion)
    }

    open func getManagersInBatchMode(userId: String?, query: String? = nil, completion: UsersBatchClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserDAO.self).getManagersInBatchMode(userId: userId, query: query, completion: completion)
    }

    open func newCreator(data creatorData: NewCreatorData, completion: UserClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserDAO.self).newCreator(data: creatorData, completion: completion)
    }

    open func editProfile(userId identifier: String, data: EditProfileData, completion: ErrorClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserDAO.self).editProfile(identifier: identifier, data: data, completion: completion)
    }

    open func createMultipleCreators(data: CreateMultipleCreatorsData, completion: ErrorClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserDAO.self).createMultipleCreators(data, completion: completion)
    }

    open func getMyConnections(query: String?, pagingData: PagingData?, completion: UsersClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserDAO.self).getMyConnections(pagingData: pagingData, query: query, completion: completion)
    }

    open func getOtherUsersMyConnections(userId: String, query: String?, pagingData: PagingData?, completion: UsersClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserDAO.self).getOtherUsersMyConnections(userId: userId, query: query, pagingData: pagingData, completion: completion)
    }

    open func getUsersFollowedByAUser(userId: String, pagingData: PagingData?, completion: UsersClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserDAO.self).getUsersFollowedByAUser(userId, pagingData: pagingData, completion: completion)
    }

    open func getUserAccountData(userId: String, completion: UserAccountDetailsClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserDAO.self).getUserAccountData(userId: userId, completion: completion)
    }
    
    open func getTrendingUsers(completion: UsersClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserDAO.self).getTrendingUsers(completion: completion)
    }
    
    open func getSuggestedUsers(completion: UsersClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserDAO.self).getSuggestedUsers(completion: completion)
    }
    
    open func batchFollow(users: [String], completion: ErrorClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserDAO.self).batchFollow(users:users, completion: completion)
    }

    open func getUserFollowers(userId: String, pagingData: PagingData?, completion: UsersClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserDAO.self).getFollowers(userId, pagingData: pagingData, completion: completion)
    }
    
    open func getUserFollowedHashtags(userId: String, pagingData: PagingData?, completion: HashtagsClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserDAO.self).getFollowedHashtags(userId, pagingData: pagingData, completion: completion)
    }
    
    open func searchInFollowedUsers(userId: String, query: String, pagingData: PagingData?, completion: UsersClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserDAO.self).searchInFollowedUsers(userId, query: query, pagingData: pagingData, completion: completion)
    }
    
    open func searchInFollowedHashtags(userId: String, query: String, pagingData: PagingData?, completion: HashtagsClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserDAO.self).searchInFollowedHashtags(userId, query: query, pagingData: pagingData, completion: completion)
    }
    
    open func searchInFollowers(userId: String, query: String, pagingData: PagingData?, completion: UsersClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserDAO.self).searchInFollowers(userId, query: query, pagingData: pagingData, completion: completion)
    }
    
    // MARK: - Gallery managment
    open func getGallery(galleryId: String, completion: GalleryClosure?) -> RequestHandler {
        return daoAssembly.assembly(GalleryDAO.self).getGallery(galleryIdentifier: galleryId, completion: completion)
    }

    open func getGalleries(creationId: String, pagingData: PagingData?, sort: SortOrder?, filter: GalleriesRequestFilter?, completion: GalleriesClosure?) -> RequestHandler {
        return daoAssembly.assembly(GalleryDAO.self).getGalleries(creationIdentifier: creationId, pagingData: pagingData, sort: sort, filter: filter, completion: completion)
    }

    open func getGalleries(userId: String?, query: String? = nil, pagingData: PagingData?, sort: SortOrder?, filter: GalleriesRequestFilter?, completion: GalleriesClosure?) -> RequestHandler {
        return daoAssembly.assembly(GalleryDAO.self).getGalleries(userIdentifier: userId, query: query, pagingData: pagingData, sort: sort, filter: filter, completion: completion)
    }

    open func getGalleriesInBatchMode(userId: String?, query: String? = nil, sort: SortOrder?, filter: GalleriesRequestFilter?, completion: GalleriesBatchClosure?) -> RequestHandler {
        return daoAssembly.assembly(GalleryDAO.self).getGalleriesInBatchMode(userIdentifier: userId, query:query, sort: sort, filter: filter, completion: completion)
    }

    open func getMyGalleries(_ pagingData: PagingData?, completion: GalleriesClosure?) -> RequestHandler {
        return daoAssembly.assembly(GalleryDAO.self).getMyGalleries(pagingData, completion: completion)
    }

    open func getMyOwnedGalleries(_ pagingData: PagingData?, completion: GalleriesClosure?) -> RequestHandler {
        return daoAssembly.assembly(GalleryDAO.self).getMyOwnedGalleries(pagingData, completion: completion)
    }

    open func getMySharedGalleries(_ pagingData: PagingData?, completion: GalleriesClosure?) -> RequestHandler {
        return daoAssembly.assembly(GalleryDAO.self).getMySharedGalleries(pagingData, completion: completion)
    }

    open func getMyFavoriteGalleries(_ pagingData: PagingData?, completion: GalleriesClosure?) -> RequestHandler {
        return daoAssembly.assembly(GalleryDAO.self).getMyFavoriteGalleries(pagingData, completion: completion)
    }

    open func getFeaturedGalleries(_ pagingData: PagingData?, completion: GalleriesClosure?) -> RequestHandler {
        return daoAssembly.assembly(GalleryDAO.self).getFeaturedGalleries(pagingData, completion: completion)
    }

    open func getChallengeGalleries(_ pagingData: PagingData?, completion: GalleriesClosure?) -> RequestHandler {
        return daoAssembly.assembly(GalleryDAO.self).getChallengeGalleries(pagingData, completion: completion)
    }
    
    open func getMyGalleriesInBatchMode(_ completion: GalleriesBatchClosure?) -> RequestHandler {
        return daoAssembly.assembly(GalleryDAO.self).getMyGalleriesInBatchMode(completion)
    }

    open func getOwnedGalleriesInBatchMode(_ completion: GalleriesBatchClosure?) -> RequestHandler {
        return daoAssembly.assembly(GalleryDAO.self).getMyOwnedGalleriesInBatchMode(completion)
    }

    open func getSharedGalleriesInBatchMode(_ completion: GalleriesBatchClosure?) -> RequestHandler {
        return daoAssembly.assembly(GalleryDAO.self).getMySharedGalleriesInBatchMode(completion)
    }

    open func getFavoriteGalleriesInBatchMode(_ completion: GalleriesBatchClosure?) -> RequestHandler {
        return daoAssembly.assembly(GalleryDAO.self).getFavoriteGalleriesInBatchMode(completion)
    }

    open func getFeaturedGalleriesInBatchMode(_ completion: GalleriesBatchClosure?) -> RequestHandler {
        return daoAssembly.assembly(GalleryDAO.self).getFeaturedGalleriesInBatchMode(completion)
    }

    open func newGallery(data galleryData: NewGalleryData, completion: GalleryClosure?) -> RequestHandler {
        return daoAssembly.assembly(GalleryDAO.self).newGallery(data: galleryData, completion: completion)
    }

    open func updateGallery(data: UpdateGalleryData, completion: ErrorClosure?) -> RequestHandler {
        return daoAssembly.assembly(GalleryDAO.self).updateGallery(data: data, completion: completion)
    }

    open func reportGallery(galleryId: String, message: String, completion: ErrorClosure?) -> RequestHandler {
        return daoAssembly.assembly(GalleryDAO.self).reportGallery(galleryIdentifier: galleryId, message: message, completion: completion)
    }

    open func submitCreationToGallery(galleryId: String, creationId: String, completion: @escaping ErrorClosure) -> RequestHandler {
        return daoAssembly.assembly(GalleryDAO.self).submitCreationToGallery(galleryIdentifier: galleryId, creationId: creationId, completion: completion)
    }

    open func submitCreationToGalleries(creationId: String, galleryIdentifiers: Array<String>, completion: ErrorClosure?) -> RequestHandler {
        return daoAssembly.assembly(GalleryDAO.self).submitCreationToGalleries(creationId: creationId, galleryIdentifiers: galleryIdentifiers, completion: completion)
    }
    
    open func incrementViewsCount(galleryIdentifier galleryId: String, completion: ErrorClosure?) -> RequestHandler {
        return daoAssembly.assembly(GalleryDAO.self).incrementViewsCount(galleryIdentifier: galleryId, completion: completion)
    }
    
    // MARK: - Creation managment
    open func getCreation(creationId: String, completion: CreationClosure?) -> RequestHandler {
        return daoAssembly.assembly(CreationsDAO.self).getCreation(creationIdentifier: creationId, completion: completion)
    }

    open func reportCreation(creationId: String, message: String, completion: ErrorClosure?) -> RequestHandler {
        return daoAssembly.assembly(CreationsDAO.self).reportCreation(creationIdentifier: creationId, message: message, completion: completion)
    }

    open func getCreations(galleryId: String?, userId: String?, keyword: String?, pagingData: PagingData?, sortOrder: SortOrder?, partnerApplicationId: String?, onlyPublic: Bool, completion: CreationsClosure?) -> RequestHandler {
        return daoAssembly.assembly(CreationsDAO.self).getCreations(galleryIdentifier: galleryId, userId: userId, keyword: keyword, pagingData: pagingData, sortOrder: sortOrder, partnerApplicationId: partnerApplicationId, onlyPublic: onlyPublic, completion: completion)
    }

    open func getRecomendedCreationsByUser(userId: String, pagingData: PagingData?, completon: CreationsClosure?) -> RequestHandler {
        return daoAssembly.assembly(CreationsDAO.self).getRecomendedCreationsByUser(userIdentifier: userId, pagingData: pagingData, completon: completon)
    }

    open func getRecomendedCreationsByCreation(creationId: String, pagingData: PagingData?, completon: CreationsClosure?) -> RequestHandler {
        return daoAssembly.assembly(CreationsDAO.self).getRecomendedCreationsByCreation(creationIdentifier: creationId, pagingData: pagingData, completon: completon)
    }

    open func editCreation(creationId: String, data: EditCreationData, completion: ErrorClosure?) -> RequestHandler {
        return daoAssembly.assembly(CreationsDAO.self).editCreation(creationIdentifier: creationId, data: data, completion: completion)
    }

    open func getCreationsInBatchMode(galleryId: String?, userId: String?, keyword: String?, partnerApplicationId: String?, sortOrder: SortOrder?, onlyPublic: Bool, completion: CreationsBatchClosure?) -> RequestHandler {
        return daoAssembly.assembly(CreationsDAO.self).getCreationsInBatchMode(galleryIdentifier: galleryId, userId: userId, keyword: keyword, sortOrder: sortOrder, partnerApplicationId: partnerApplicationId, onlyPublic: onlyPublic, completion: completion)
    }

    open func removeCreation(creationId: String, completion: ErrorClosure?) -> RequestHandler {
        return daoAssembly.assembly(CreationsDAO.self).removeCreation(creationIdentifier: creationId, completion: completion)
    }

    open func getToybooCreation(creationId: String, completion: ToybooCreationClosure?) -> RequestHandler {
        return daoAssembly.assembly(CreationsDAO.self).getToybooCreation(creationIdentifier: creationId, completion: completion)
    }
    
    open func incrementViewsCount(creationIdentifier creationId: String, completion: ErrorClosure?) -> RequestHandler {
        return daoAssembly.assembly(CreationsDAO.self).incrementViewsCount(creationIdentifier: creationId, completion: completion)
    }
    
    open func getTrendingCreations(completion: CreationsClosure?) -> RequestHandler {
        return daoAssembly.assembly(CreationsDAO.self).getTrendingCreations(completion: completion)
    }
    
    // MARK: - Upload Sessions
    open func getAllActiveUploadSessionPublicData() -> Array<CreationUploadSessionPublicData> {
        return creationUploadService.getAllActiveUploadSessionsPublicData()
    }

    open func getAllFinishedUploadSessionPublicData() -> Array<CreationUploadSessionPublicData> {
        return creationUploadService.getAllFinishedUploadSessionPublicData()
    }

    open func getAllNotFinishedUploadSessionsPublicData() -> Array<CreationUploadSessionPublicData> {
        return creationUploadService.getAllNotFinishedUploadSessionsPublicData()
    }

    open func startAllNotFinishedUploadSessions(_ completion: CreationClosure?) {
        creationUploadService.startAllNotFinishedUploadSessions(completion)
    }

    open func cancelUploadSession(sessionId: String) {
        creationUploadService.removeUploadSession(sessionIdentifier: sessionId)
    }

    open func removeAllUploadSessions() {
        creationUploadService.removeAllUploadSessions()
    }

    open func startUploadSession(sessionId: String) {
        creationUploadService.startUploadSession(sessionIdentifier: sessionId)
    }

    open func refreshCreationStatusInUploadSession(sessionId: String) {
        creationUploadService.refreshCreationStatusInUploadSession(sessionId: sessionId)
    }

    open func refreshCreationStatusInUploadSession(creationId: String) {
        creationUploadService.refreshCreationStatusInUploadSession(creationId: creationId)
    }

    open func notifyCreationProcessingFailed(creationId: String) {
        creationUploadService.notifyCreationProcessingFailed(creationId: creationId)
    }

    // MARK: - Creation flow
    open func newCreation(data creationData: NewCreationData, localDataPreparationCompletion: ((_ error: Error?) -> Void)?, completion: CreationClosure?) -> CreationUploadSessionPublicData? {
        return creationUploadService.uploadCreation(data: creationData, localDataPreparationCompletion: localDataPreparationCompletion, completion: completion)
    }

    // MARK: - Background session
    open var backgroundCompletionHandler: (() -> Void)? {
        get {
            return requestSender.backgroundCompletionHandler
        }
        set {
            requestSender.backgroundCompletionHandler = newValue
        }
    }

    // MARK: - Bubbles
    open func getBubbles(creationId identifier: String, pagingData: PagingData?, completion: BubblesClousure?) -> RequestHandler {
        return daoAssembly.assembly(BubbleDAO.self).getBubbles(creationIdentifier: identifier, pagingData: pagingData, completion: completion)
    }

    open func getBubbles(userId identifier: String, pagingData: PagingData?, completion: @escaping BubblesClousure) -> RequestHandler {
        return daoAssembly.assembly(BubbleDAO.self).getBubbles(userIdentifier: identifier, pagingData: pagingData, completion: completion)
    }

    open func getBubbles(galleryId identifier: String, pagingData: PagingData?, completion: @escaping BubblesClousure) -> RequestHandler {
        return daoAssembly.assembly(BubbleDAO.self).getBubbles(galleryIdentifier: identifier, pagingData: pagingData, completion: completion)
    }

    open func newBubble(data: NewBubbleData, completion: BubbleClousure?) -> RequestHandler {
        return daoAssembly.assembly(BubbleDAO.self).newBubble(data: data, completion: completion)
    }

    open func updateBubble(data: UpdateBubbleData, completion: BubbleClousure?) -> RequestHandler {
        return daoAssembly.assembly(BubbleDAO.self).updateBubble(data: data, completion: completion)
    }

    open func deleteBubble(bubbleId: String, completion: ErrorClosure?) -> RequestHandler {
        return daoAssembly.assembly(BubbleDAO.self).deleteBubble(bubbleIdentifier: bubbleId, completion: completion)
    }
    // MARK: - Groups

    open func fetchGroup(groupId identifier: String, completion: GroupClosure?) -> RequestHandler {
        return daoAssembly.assembly(GroupDAO.self).fetchGroup(groupIdentifier: identifier, completion: completion)
    }

    open func fetchGroups(_ completion: GroupsClosure?) -> RequestHandler {
        return daoAssembly.assembly(GroupDAO.self).fetchGroups(completion)
    }

    open func newGroup(data: NewGroupData, completion: GroupClosure?) -> RequestHandler {
        return daoAssembly.assembly(GroupDAO.self).newGroup(newGroupData: data, completion: completion)
    }

    open func editGroup(groupId identifier: String, data: EditGroupData, completion: ErrorClosure?) -> RequestHandler {
        return daoAssembly.assembly(GroupDAO.self).editGroup(groupIdentifier: identifier, data: data, completion: completion)
    }

    open func deleteGroup(groupId identifier: String, completion: ErrorClosure?) -> RequestHandler {
        return daoAssembly.assembly(GroupDAO.self).deleteGroup(groupIdentifier: identifier, completion: completion)
    }

    // MARK: - Comments
    open func addComment(data: NewCommentData, completion: ErrorClosure?) -> RequestHandler {
        return daoAssembly.assembly(CommentsDAO.self).addComment(commendData: data, completion: completion)
    }
    
    open func approveComment(commentId: String, completion: ErrorClosure?) -> RequestHandler {
        return daoAssembly.assembly(CommentsDAO.self).approveComment(commentIdentifier: commentId, completion: completion)
    }

    open func declineComment(commentId: String, completion: ErrorClosure?) -> RequestHandler {
        return daoAssembly.assembly(CommentsDAO.self).declineComment(commentIdentifier: commentId, completion: completion)
    }

    open func reportComment(commentId: String, message: String, completion: ErrorClosure?) -> RequestHandler {
        return daoAssembly.assembly(CommentsDAO.self).reportComment(commentIdentifier: commentId, message: message, completion: completion)
    }

    open func getComments(creationId: String, pagingData: PagingData?, completion: CommentsClosure?) -> RequestHandler {
        return daoAssembly.assembly(CommentsDAO.self).getComments(creationIdentifier: creationId, pagingData: pagingData, completion: completion)
    }

    open func getComments(userId: String, pagingData: PagingData?, completion: CommentsClosure?) -> RequestHandler {
        return daoAssembly.assembly(CommentsDAO.self).getComments(userIdentifier: userId, pagingData: pagingData, completion: completion)
    }

    open func getComments(galleryId: String, pagingData: PagingData?, completion: CommentsClosure?) -> RequestHandler {
        return daoAssembly.assembly(CommentsDAO.self).getComments(galleryIdentifier: galleryId, pagingData: pagingData, completion: completion)
    }

    // MARK: - Content
    open func getTrendingContent(pagingData: PagingData?, completion: ContentEntryClosure?) -> RequestHandler {
        return daoAssembly.assembly(ContentDAO.self).getTrendingContent(pagingData: pagingData, completion: completion)
    }

    open func getRecentContent(pagingData: PagingData?, completion: ContentEntryClosure?) -> RequestHandler {
        return daoAssembly.assembly(ContentDAO.self).getRecentContent(pagingData: pagingData, completion: completion)
    }

    open func getBubbledContent(userId: String, pagingData: PagingData?, completion: ContentEntryClosure?) -> RequestHandler {
        return daoAssembly.assembly(ContentDAO.self).getUserBubbledContent(userIdentifier: userId, pagingData: pagingData, completion: completion)
    }

    open func getMyConnectionsContent(pagingData: PagingData?, completion: ContentEntryClosure?) -> RequestHandler {
        return daoAssembly.assembly(ContentDAO.self).getMyConnectionsContent(pagingData: pagingData, completion: completion)
    }

    open func getContentsByAUser(userId: String, pagingData: PagingData?, completion: ContentEntryClosure?) -> RequestHandler {
        return daoAssembly.assembly(ContentDAO.self).getContentsByAUser(userIdentfier: userId, pagingData: pagingData, completion: completion)
    }

    open func getFollowedContents(_ pagingData: PagingData?, completion: ContentEntryClosure?) -> RequestHandler {
        return daoAssembly.assembly(ContentDAO.self).getFollowedContents(pagingData, completion: completion)
    }

    open func getSearchedContents(query: String, pagingData: PagingData?, completion: ContentEntryClosure?) -> RequestHandler {
        return daoAssembly.assembly(ContentDAO.self).getSearchedContents(query: query, pagingData: pagingData, completion: completion)
    }
    
    open func getContentsByHashtag(hashtag: String, pagingData: PagingData?, completion: ContentEntryClosure?) -> RequestHandler {
        return daoAssembly.assembly(ContentDAO.self).getContentsByHashtag(hashtag:hashtag, pagingData: pagingData, completion: completion)
    }

    // MARK: - CustomStyle
    open func fetchCustomStyleForUser(userId identifier: String, completion: CustomStyleClosure?) -> RequestHandler {
        return daoAssembly.assembly(CustomStyleDAO.self).fetchCustomStyleForUser(userIdentifier: identifier, completion: completion)
    }

    open func editCustomStyleForUser(userId identifier: String, withData data: CustomStyleEditData, completion: CustomStyleClosure?) -> RequestHandler {
        return daoAssembly.assembly(CustomStyleDAO.self).editCustomStyleForUser(userIdentifier: identifier, withData: data, completion: completion)
    }

    // MARK: - Activities

    open func getActivities(pagingData: PagingData?, completion: ActivitiesClosure?) -> RequestHandler {
        return daoAssembly.assembly(ActivitiesDAO.self).getActivities(pagingData, completion: completion)
    }

    // MARK: - Notifications

    open func getNotifications(pagingData: PagingData?, completion: NotificationsClosure?) -> RequestHandler {
        return daoAssembly.assembly(NotificationDAO.self).getNotifications(pagingData: pagingData, completion: completion)
    }

    open func markNotificationAsRead(notificationId: String, from: String? = nil, completion: ErrorClosure?) -> RequestHandler {
        return daoAssembly.assembly(NotificationDAO.self).markNotificationAsRead(notificationIdentifier: notificationId, from: from, completion: completion)
    }

    open func trackWhenNotificationsWereViewed(completion: ErrorClosure?) -> RequestHandler {
        return daoAssembly.assembly(NotificationDAO.self).trackWhenNotificationsWereViewed(completion: completion)
    }

    // MARK: - User Followings
    open func createUserFollowing(userId: String, completion: ErrorClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserFollowingsDAO.self).createAUserFollowing(userId, completion: completion)
    }

    open func deleteAUserFollowing(userId: String, completion: ErrorClosure?) -> RequestHandler {
        return daoAssembly.assembly(UserFollowingsDAO.self).deleteAUserFollowing(userId, completion: completion)
    }
    
    // MARK: - Hashtags Followings
    open func fetchHashtag(hashtagId: String, completion: HashtagClosure?) -> RequestHandler {
        return daoAssembly.assembly(HashtagDAO.self).fetchHashtag(hashtagId, completion:completion)
    }
    
    open func createHashtagFollowing(hashtagId: String, completion: ErrorClosure?) -> RequestHandler {
        return daoAssembly.assembly(HashtagDAO.self).createAHashtagFollowing(hashtagId, completion: completion)
    }
    
    open func deleteAHashtagFollowing(hashtagId: String, completion: ErrorClosure?) -> RequestHandler {
        return daoAssembly.assembly(HashtagDAO.self).deleteAHashtagFollowing(hashtagId, completion: completion)
    }
    
    open func getHashtagFollowers(hashtagId: String, pagingData: PagingData?, completion: UsersClosure?) -> RequestHandler {
        return daoAssembly.assembly(HashtagDAO.self).getFollowers(hashtagId, pagingData: pagingData, completion: completion)
    }

    // MARK: - Partner Applications
    open func getPartnerApplication(_ id: String, completion: PartnerApplicationClosure?) -> RequestHandler {
        return daoAssembly.assembly(PartnerApplicationDAO.self).getPartnerApplication(id, completion: completion)
    }

    open func searchPartnerApplications(_ query: String, completion: PartnerApplicationsClosure?) -> RequestHandler {
        return daoAssembly.assembly(PartnerApplicationDAO.self).searchPartnerApplications(query, completion: completion)
    }
    
    open func getPartnerApplicationGalleries(_ id: String, pagingData: PagingData, completion: GalleriesClosure?) -> RequestHandler {
        return daoAssembly.assembly(PartnerApplicationDAO.self).getPartnerApplicationGalleries(id, pagingData: pagingData, completion: completion)
    }
    
    open func getPartnerApplicationCreations(_ id: String, pagingData: PagingData, completion: CreationsClosure?) -> RequestHandler {
        return daoAssembly.assembly(PartnerApplicationDAO.self).getPartnerApplicationCreations(id, pagingData: pagingData, completion: completion)
    }

    // MARK: - Avatar

    open func getSuggestedAvatars(completion: AvatarSuggestionsClosure?) -> RequestHandler {
        return daoAssembly.assembly(AvatarDAO.self).getSuggestedAvatars(completion: completion)
    }

    open func updateUserAvatar(userId: String, data: UpdateAvatarData, completion: ErrorClosure?) -> RequestHandler {
        return daoAssembly.assembly(AvatarDAO.self).updateUserAvatar(userId: userId, data: data, completion: completion)
    }

    // MARK: - SearchTags
    open func getSearchTags(pagingData: PagingData?, completion: SearchTagsClosure?) -> RequestHandler {
        return daoAssembly.assembly(SearchTagDAO.self).fetchSearchTags(pagingData: pagingData, completion: completion)
    }
    
    // MARK: - Hashtags
    open func getSuggestedHashtags(pagingData: PagingData?, completion: HashtagsClosure?) -> RequestHandler {
        return daoAssembly.assembly(HashtagDAO.self).fetchSuggestedHashtags(pagingData: pagingData, completion: completion)
    }

    // MARK: - Log listener
    open func addLoggerListnerer(_ listener: LogListener) {
        Logger.addListener(listener: listener)
    }

    // MARK: - Delegate
    func creationUploadService(_ sender: CreationUploadService, newSessionAdded session: CreationUploadSession) {
        let data = CreationUploadSessionPublicData(creationUploadSession: session)
        delegate?.creatubblesAPIClientNewImageUpload(self, uploadSessionData: data)
    }

    func creationUploadService(_ sender: CreationUploadService, uploadFinished session: CreationUploadSession) {
        let data = CreationUploadSessionPublicData(creationUploadSession: session)
        delegate?.creatubblesAPIClientImageUploadFinished(self, uploadSessionData: data)
    }

    func creationUploadService(_ sender: CreationUploadService, progressChanged session: CreationUploadSession, completedUnitCount: Int64, totalUnitcount: Int64, fractionCompleted: Double) {
        let data = CreationUploadSessionPublicData(creationUploadSession: session)
        delegate?.creatubblesAPIClientImageUploadProcessChanged(self, uploadSessionData: data, completedUnitCount: completedUnitCount, totalUnitcount, fractionCompleted)
    }

    func creationUploadService(_ sender: CreationUploadService, uploadFailed session: CreationUploadSession, withError error: Error) {
        let data = CreationUploadSessionPublicData(creationUploadSession: session)
        delegate?.creatubblesAPIClientImageUploadFailed(self, uploadSessionData: data, error: APIClient.errorTypeToNSError(error)!)
    }
}
