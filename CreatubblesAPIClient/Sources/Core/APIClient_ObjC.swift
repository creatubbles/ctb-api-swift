//
//  CreatubblesAPIClient_ObjC.swift
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
extension APIClient {
    // MARK: - Session
    public func _login(_ username: String, password: String, completion: ((NSError?) -> (Void))?) -> RequestHandler {
        return login(username: username, password: password) {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }

    public func _authenticate(completion: ((NSError?) -> (Void))?) -> RequestHandler {
        return authenticate {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }

    public func _logout() {
        logout()
    }

    public func _isLoggedIn() -> Bool {
        return isLoggedIn()
    }

    public func _getLandingURL(_ type: LandingURLType, completion: ((Array<LandingURL>?, NSError?) -> (Void))?) -> RequestHandler {
        return getLandingURL(type: type) {
            (landingUrls, error) -> (Void) in
            completion?(landingUrls, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getLandingURLForCreation(_ creationId: String, completion: ((Array<LandingURL>?, NSError?) -> (Void))?) -> RequestHandler {
        return getLandingURL(creationId: creationId) {
            (landingUrls, error) -> (Void) in
            completion?(landingUrls, APIClient.errorTypeToNSError(error))
        }
    }

    // MARK: - Users handling
    public func _getUser(_ userId: String, completion: ((User?, NSError?) -> (Void))?) -> RequestHandler {
        return getUser(userId: userId) {
            (user, error) -> (Void) in
            completion?(user, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getCurrentUser(_ completion: ((User?, NSError?) -> (Void))?) -> RequestHandler {
        return getCurrentUser {
                (user, error) -> (Void) in
                completion?(user, APIClient.errorTypeToNSError(error))
        }
    }

    public func _switchUser(targetUserId: String, accessToken: String, completion: ((String?, NSError?) -> (Void))?) -> RequestHandler {
        return switchUser(targetUserId: targetUserId, accessToken: accessToken) {
            (accessToken, error) -> (Void) in
            completion?(accessToken, APIClient.errorTypeToNSError(error))
        }
    }

    public func _reportUser(userId: String, message: String, completion: ((NSError?) -> (Void))?) -> RequestHandler {
        return reportUser(userId: userId, message: message) {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }

    public func _getCreators(userId: String?, query: String?, pagingData: PagingData?, completion: ((Array<User>?, PagingInfo?, NSError?) -> (Void))?) -> RequestHandler {
        return getCreators(userId: userId, query: query, pagingData: pagingData) {
            (users, pInfo, error) -> (Void) in
            completion?(users, pInfo, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getCreators(groupId: String, pagingData: PagingData?, completion: ((Array<User>?, PagingInfo?, NSError?) -> (Void))?) -> RequestHandler {
        return getCreators(groupId: groupId, pagingData: pagingData) {
            (users, pInfo, error) -> (Void) in
            completion?(users, pInfo, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getSwitchUsers(query: String?, pagingData: PagingData?, completion: ((Array<User>?, PagingInfo?, NSError?) -> (Void))?) -> RequestHandler {
        return getSwitchUsers(query: query, pagingData: pagingData) {
            (users, pInfo, error) -> (Void) in
            completion?(users, pInfo, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getManagers(_ userId: String?, query: String?, pagingData: PagingData?, completion: ((Array<User>?, PagingInfo?, NSError?) -> (Void))?) -> RequestHandler {
        return getManagers(userId: userId, query: query, pagingData: pagingData) {
            (users, pInfo, error) -> (Void) in
            completion?(users, pInfo, APIClient.errorTypeToNSError(error))
        }
    }

    public func _newCreator(_ creatorData: NewCreatorData, completion: ((User?, NSError?) -> (Void))?) -> RequestHandler {
        return newCreator(data: creatorData) {
            (user, error) -> (Void) in
            completion?(user, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getGroupCreatorsInBatchMode(groupId: String, completion: ((Array<User>?, NSError?) -> (Void))?) -> RequestHandler {
        return getGroupCreatorsInBatchMode(groupId: groupId) {
            (users, error) -> (Void) in
            completion?(users, APIClient.errorTypeToNSError(error))
        }
    }

    public func _editProfile(identifier: String, data: EditProfileData, completion: ((NSError?) -> (Void))?) -> RequestHandler {
        return editProfile(userId: identifier, data: data) {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }

    public func _createMultipleCreators(data: CreateMultipleCreatorsData, completion: ((NSError?) -> (Void))?) -> RequestHandler {
        return createMultipleCreators(data: data) {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }

    public func _getMyConnections(query: String?, pagingData: PagingData?, completion: ((Array<User>?, PagingInfo?, NSError?) -> (Void))?) -> RequestHandler {
        return getMyConnections(query: query, pagingData: pagingData) {
            (users, pInfo, error) -> (Void) in
            completion?(users, pInfo, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getOtherUsersMyConnections(userId: String, query: String?, pagingData: PagingData?, completion: ((Array<User>?, PagingInfo?, NSError?) -> (Void))?) -> RequestHandler {
        return getOtherUsersMyConnections(userId: userId, query:query, pagingData: pagingData) {
            (users, pInfo, error) -> (Void) in
            completion?(users, pInfo, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getUsersFollowedByAUser(userId: String, pagingData: PagingData?, completion: ((Array<User>?, PagingInfo?, NSError?) -> (Void))?) -> RequestHandler {
        return getUsersFollowedByAUser(userId: userId, pagingData: pagingData) {
            (users, pInfo, error) -> (Void) in
            completion?(users, pInfo, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getUserAccountData(userId: String, completion: ((UserAccountDetails?, NSError?) -> (Void))?) -> RequestHandler {
        return getUserAccountData(userId: userId) {
            (userAccountDetails, error) -> (Void) in
            completion?(userAccountDetails, APIClient.errorTypeToNSError(error))
        }
    }

    // MARK: - Gallery handling
    public func _getGallery(_ galleryId: String, completion: ((Gallery?, NSError?) -> (Void))?) -> RequestHandler {
        return getGallery(galleryId: galleryId) {
            (gallery, error) -> (Void) in
            completion?(gallery, APIClient.errorTypeToNSError(error))
        }
    }

    public func _newGallery(_ galleryData: NewGalleryData, completion: ((Gallery?, NSError?) -> (Void))?) -> RequestHandler {
        return newGallery(data: galleryData) {
            (gallery, error) -> (Void) in
            completion?(gallery, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getGalleries(_ userId: String?, query: String?, pagingData: PagingData?, sort: SortOrder, filter: GalleriesRequestFilter?, completion: ((Array<Gallery>?, PagingInfo?, NSError?) -> (Void))?) -> RequestHandler {
        return getGalleries(userId: userId, query:query, pagingData: pagingData, sort: sort, filter: filter) {
            (galleries, pInfo, error) -> (Void) in
            completion?(galleries, pInfo, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getGalleries(creationId: String, pagingData: PagingData?, sort: SortOrder?, filter: GalleriesRequestFilter?, completion: ((Array<Gallery>?, PagingInfo?, NSError?) -> (Void))?) -> RequestHandler {
        return getGalleries(creationId: creationId, pagingData: pagingData, sort: sort, filter: filter) {
            (galleries, pInfo, error) -> (Void) in
            completion?(galleries, pInfo, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getMyGalleries(pagingData: PagingData?, completion: ((Array<Gallery>?, PagingInfo?, NSError?) -> (Void))?) -> RequestHandler {
        return getMyGalleries(pagingData) {
            (galleries, pInfo, error) -> (Void) in
            completion?(galleries, pInfo, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getMyOwnedGalleries(pagingData: PagingData?, completion: ((Array<Gallery>?, PagingInfo?, NSError?) -> (Void))?) -> RequestHandler {
        return getMyOwnedGalleries(pagingData) {
            (galleries, pInfo, error) -> (Void) in
            completion?(galleries, pInfo, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getMySharedGalleries(pagingData: PagingData?, completion: ((Array<Gallery>?, PagingInfo?, NSError?) -> (Void))?) -> RequestHandler {
        return getMySharedGalleries(pagingData) {
            (galleries, pInfo, error) -> (Void) in
            completion?(galleries, pInfo, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getMyFavoriteGalleries(pagingData: PagingData?, completion: ((Array<Gallery>?, PagingInfo?, NSError?) -> (Void))?) -> RequestHandler {
        return getMyFavoriteGalleries(pagingData) {
            (galleries, pInfo, error) -> (Void) in
            completion?(galleries, pInfo, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getFeaturedGalleries(pagingData: PagingData?, completion: ((Array<Gallery>?, PagingInfo?, NSError?) -> (Void))?) -> RequestHandler {
        return getFeaturedGalleries(pagingData) {
            (galleries, pInfo, error) -> (Void) in
            completion?(galleries, pInfo, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getMyGalleriesInBatchMode(completion: ((Array<Gallery>?, NSError?) -> (Void))?) -> RequestHandler {
        return getMyGalleriesInBatchMode {
                (galleries, error) -> (Void) in
                completion?(galleries, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getOwnedGalleriesInBatchMode(completion: ((Array<Gallery>?, NSError?) -> (Void))?) -> RequestHandler {
        return getOwnedGalleriesInBatchMode {
                (galleries, error) -> (Void) in
                completion?(galleries, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getSharedGalleriesInBatchMode(completion: ((Array<Gallery>?, NSError?) -> (Void))?) -> RequestHandler {
        return getSharedGalleriesInBatchMode {
                (galleries, error) -> (Void) in
                completion?(galleries, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getFavoriteGalleriesInBatchMode(completion: ((Array<Gallery>?, NSError?) -> (Void))?) -> RequestHandler {
        return getFavoriteGalleriesInBatchMode {
                (galleries, error) -> (Void) in
                completion?(galleries, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getFeaturedGalleriesInBatchMode(completion: ((Array<Gallery>?, NSError?) -> (Void))?) -> RequestHandler {
        return getFeaturedGalleriesInBatchMode {
                (galleries, error) -> (Void) in
                completion?(galleries, APIClient.errorTypeToNSError(error))
        }
    }

    public func _updateGallery(data: UpdateGalleryData, completion: ((NSError?) -> (Void))?) -> RequestHandler {
        return updateGallery(data: data) {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }

    public func _reportGallery(galleryId: String, message: String, completion: ((NSError?) -> (Void))?) -> RequestHandler {
        return reportGallery(galleryId: galleryId, message: message) {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }

    public func _submitCreationToGallery(galleryId: String, creationId: String, completion: ((NSError?) -> (Void))?) -> RequestHandler {
        return submitCreationToGallery(galleryId: galleryId, creationId: creationId) {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }

    // MARK: - Creation handling
    public func _getCreation(_ creationId: String, completion: ((Creation?, NSError?) -> (Void))?) -> RequestHandler {
        return getCreation(creationId: creationId) {
            (creation, error) -> (Void) in
            completion?(creation, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getCreations(_ galleryId: String, userId: String?, keyword: String?, pagingData: PagingData?, sortOrder: SortOrder, partnerApplicationId: String?, onlyPublic: Bool, completion: ((Array<Creation>?, PagingInfo?, NSError?) -> (Void))?) -> RequestHandler {
        return getCreations(galleryId: galleryId, userId: userId, keyword: keyword, pagingData: pagingData, sortOrder: sortOrder, partnerApplicationId: partnerApplicationId, onlyPublic: onlyPublic) {
            (creations, pInfo, error) -> (Void) in
            completion?(creations, pInfo, APIClient.errorTypeToNSError(error))
        }
    }

    public func _newCreation(_ creationData: NewCreationData, completion: ((Creation?, NSError?) -> (Void))?) -> CreationUploadSessionPublicData? {
        return newCreation(data: creationData) {
            (creation, error) -> (Void) in
            completion?(creation, APIClient.errorTypeToNSError(error))
        }
    }

    public func _reportCreation(creationId: String, message: String, completion: ((NSError?) -> (Void))?) -> RequestHandler {
        return reportCreation(creationId: creationId, message: message) {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }

    public func _getRecommendedCreationsByUser(userId: String, pagingData: PagingData?, completion: ((Array<Creation>?, PagingInfo?, NSError?) -> (Void))?) -> RequestHandler {
        return getRecomendedCreationsByUser(userId: userId, pagingData: pagingData) {
            (creations, pInfo, error) -> (Void) in
            completion?(creations, pInfo, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getRecommendedCreationsByCreation(creationId: String, pagingData: PagingData?, completion: ((Array<Creation>?, PagingInfo?, NSError?) -> (Void))?) -> RequestHandler {
        return getRecomendedCreationsByCreation(creationId: creationId, pagingData: pagingData) {
            (creations, pInfo, error) -> (Void) in
            completion?(creations, pInfo, APIClient.errorTypeToNSError(error))
        }
    }

    public func _editCreation(creationId: String, data: EditCreationData, completion: ((NSError?) -> (Void))?) -> RequestHandler {
        return editCreation(creationId: creationId, data: data) {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }

    public func _removeCreation(creationId: String, completion: ((NSError?) -> (Void))?) -> RequestHandler {
        return removeCreation(creationId: creationId) {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }

    // MARK: - Batch fetching
    public func _getCreationsInBatchMode(_ galleryId: String?, userId: String?, keyword: String?, partnerApplicationId: String?, sortOrder: SortOrder, onlyPublic: Bool, completion: ((Array<Creation>?, NSError?) -> (Void))?) -> RequestHandler {
        return getCreationsInBatchMode(galleryId: galleryId, userId: userId, keyword: keyword, partnerApplicationId: partnerApplicationId, sortOrder: sortOrder, onlyPublic: onlyPublic) {
            (creations, error) -> (Void) in
            completion?(creations, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getGalleriesInBatchMode(_ userId: String?, query: String?, sort: SortOrder, filter: GalleriesRequestFilter?, completion: ((Array<Gallery>?, NSError?) -> (Void))?) -> RequestHandler {
        return getGalleriesInBatchMode(userId: userId, query:query, sort: sort, filter: filter) {
            (galleries, error) -> (Void) in
            completion?(galleries, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getCreatorsInBatchMode(_ userId: String?, query: String?, completion: ((Array<User>?, NSError?) -> (Void))?) -> RequestHandler {
        return getCreatorsInBatchMode(userId: userId, query: query) {
            (users, error) -> (Void) in
            completion?(users, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getManagersInBatchMode(_ userId: String?, query: String?, completion: ((Array<User>?, NSError?) -> (Void))?) -> RequestHandler {
        return getManagersInBatchMode(userId: userId, query: query) {
            (users, error) -> (Void) in
            completion?(users, APIClient.errorTypeToNSError(error))
        }
    }

    // MARK: - Upload Sessions
    public func _getAllActiveUploadSessionPublicData() -> Array<CreationUploadSessionPublicData> {
        return getAllActiveUploadSessionPublicData()
    }

    public func _getAllFinishedUploadSessionPublicData() -> Array<CreationUploadSessionPublicData> {
        return getAllFinishedUploadSessionPublicData()
    }

    public func _startAllNotFinishedUploadSessions(_ completion: ((Creation?, NSError?) -> (Void))?) {
        startAllNotFinishedUploadSessions {
            (creation, error) -> (Void) in
            completion?(creation, APIClient.errorTypeToNSError(error))
        }
    }

    // MARK: - Bubbles
    public func _getBubblesForCreationWithIdentifier(_ identifier: String, pagingData: PagingData?, completion: ((Array<Bubble>?, PagingInfo?, NSError?) -> (Void))?) -> RequestHandler {
        return getBubbles(creationId: identifier, pagingData: pagingData) {
            (bubbles, pInfo, error) -> (Void) in
            completion?(bubbles, pInfo, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getBubblesForUserWithIdentifier(_ identifier: String, pagingData: PagingData?, completion: ((Array<Bubble>?, PagingInfo?, NSError?) -> (Void))?) -> RequestHandler {
        return getBubbles(userId: identifier, pagingData: pagingData) {
            (bubbles, pInfo, error) -> (Void) in
            completion?(bubbles, pInfo, APIClient.errorTypeToNSError(error as Error?))
        }
    }

    public func _getBubblesForGalleryWithIdentifier(_ identifier: String, pagingData: PagingData?, completion: ((Array<Bubble>?, PagingInfo?, NSError?) -> (Void))?) -> RequestHandler {
        return getBubbles(galleryId: identifier, pagingData: pagingData) {
            (bubbles, pInfo, error) -> (Void) in
            completion?(bubbles, pInfo, APIClient.errorTypeToNSError(error as Error?))
        }
    }

    public func _newBubble(_ data: NewBubbleData, completion: ((Bubble?, NSError?) -> (Void))?) -> RequestHandler {
        return newBubble(data: data) {
            (bubble, error) -> (Void) in
            completion?(bubble, APIClient.errorTypeToNSError(error))
        }
    }

    public func _updateBubble(data: UpdateBubbleData, completion: ((Bubble?, NSError?) -> (Void))?) -> RequestHandler {
        return updateBubble(data: data) {
            (bubble, error) -> (Void) in
            completion?(bubble, APIClient.errorTypeToNSError(error))
        }
    }

    public func _deleteBubble(bubbleId: String, completion: ((NSError?) -> (Void))?) -> RequestHandler {
        return deleteBubble(bubbleId: bubbleId) {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }

    // MARK: - Toyboo Creation
    public func _getToybooCreation(creationId: String, completion: ((ToybooCreation?, NSError?) -> (Void))?) -> RequestHandler {
        return getToybooCreation(creationId: creationId) {
            (toybooCreation, error) -> (Void) in
            completion?(toybooCreation, APIClient.errorTypeToNSError(error) )
        }
    }

    // MARK: - Groups
    public func _fetchGroup(groupId: String, completion: ((Group?, NSError?) -> (Void))?) -> RequestHandler {
        return fetchGroup(groupId: groupId) {
            (group, error) -> (Void) in
            completion?(group, APIClient.errorTypeToNSError(error))
        }
    }

    public func _fetchGroups(completion: ((Array<Group>?, NSError?) -> (Void))?) -> RequestHandler {
        return fetchGroups {
                (groups, errors) -> (Void) in
                completion?(groups, APIClient.errorTypeToNSError(errors))
        }
    }

    public func _newGroup(data: NewGroupData, completion: ((Group?, NSError?) -> (Void))?) -> RequestHandler {
        return newGroup(data: data) {
            (group, error) -> (Void) in
            completion?(group, APIClient.errorTypeToNSError(error))
        }
    }

    public func _editGroup(groupId: String, data: EditGroupData, completion: ((NSError?) -> (Void))?) -> RequestHandler {
        return editGroup(groupId: groupId, data: data) {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }

    public func _deleteGroup(groupId: String, completion: ((NSError?) -> (Void))?) -> RequestHandler {
        return deleteGroup(groupId: groupId) {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }

    // MARK: - Comments
    public func _addComment(data: NewCommentData, completion: ((NSError?) -> (Void))?) -> RequestHandler {
        return addComment(data: data) {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }

    public func _addComment(commentId: String, completion: ((NSError?) -> (Void))?) -> RequestHandler {
        return declineComment(commentId: commentId) {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }

    public func _reportComment(commentId: String, message: String, completion: ((NSError?) -> (Void))?) -> RequestHandler {
        return reportComment(commentId: commentId, message: message) {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }

    public func _getComments(creationId: String, pagingData: PagingData?, completion: ((Array<Comment>?, PagingInfo?, NSError?) -> (Void))?) -> RequestHandler {
        return getComments(creationId: creationId, pagingData: pagingData) {
            (comments, pInfo, error) -> (Void) in
            completion?(comments, pInfo, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getComments(userId: String, pagingData: PagingData?, completion: ((Array<Comment>?, PagingInfo?, NSError?) -> (Void))?) -> RequestHandler {
        return getComments(userId: userId, pagingData: pagingData) {
            (comments, pInfo, error) -> (Void) in
            completion?(comments, pInfo, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getComments(galleryId: String, pagingData: PagingData?, completion: ((Array<Comment>?, PagingInfo?, NSError?) -> (Void))?) -> RequestHandler {
        return getComments(galleryId: galleryId, pagingData: pagingData) {
            (comments, pInfo, error) -> (Void) in
            completion?(comments, pInfo, APIClient.errorTypeToNSError(error))
        }
    }

    // MARK: - Contents
    public func _getTrendingContent(pagingData: PagingData?, completion: ((ResponseData<ContentEntry>) -> (Void))?) -> RequestHandler {
        return getTrendingContent(pagingData: pagingData) {
            (contentEntries) -> (Void) in
            completion?(contentEntries)
        }
    }

    public func _getRecentContent(pagingData: PagingData?, completion: ((ResponseData<ContentEntry>) -> (Void))?) -> RequestHandler {
        return getRecentContent(pagingData: pagingData) {
            (contentEntries) -> (Void) in
            completion?(contentEntries)
        }
    }

    public func _getBubbledContent(userId: String, pagingData: PagingData?, completion: ((ResponseData<ContentEntry>) -> (Void))?) -> RequestHandler {
        return getBubbledContent(userId: userId, pagingData: pagingData) {
            (contentEntries) -> (Void) in
            completion?(contentEntries)
        }
    }

    public func _getMyConnectionsContent(pagingData: PagingData?, completion: ((ResponseData<ContentEntry>) -> (Void))?) -> RequestHandler {
        return getMyConnectionsContent(pagingData: pagingData) {
            (contentEntries) -> (Void) in
            completion?(contentEntries)
        }
    }

    public func _getContentsByUser(userId: String, pagingData: PagingData?, completion: ((ResponseData<ContentEntry>) -> (Void))?) -> RequestHandler {
        return getContentsByAUser(userId: userId, pagingData: pagingData) {
            (contentEntries) -> (Void) in
            completion?(contentEntries)
        }
    }

    public func _getFollowedContents(pagingData: PagingData?, completion: ((ResponseData<ContentEntry>) -> (Void))?) -> RequestHandler {
        return getFollowedContents(pagingData) {
            (contentEntries) -> (Void) in
            completion?(contentEntries)
        }
    }

    public func _getSearchedContents(query: String, pagingData: PagingData?, completion: ((ResponseData<ContentEntry>) -> (Void))?) -> RequestHandler {
        return getSearchedContents(query: query, pagingData: pagingData) {
            (contentEntries) -> (Void) in
            completion?(contentEntries)
        }
    }

    //Mark: - Custom Style
    public func _fetchCustomStyleForUser(userId: String, completion: ((CustomStyle?, NSError?) -> (Void))?) -> RequestHandler {
        return fetchCustomStyleForUser(userId: userId) {
            (customStyle, error) -> (Void) in
            completion?(customStyle, APIClient.errorTypeToNSError(error))
        }
    }

    public func _editCustomStyleForUser(userId: String, data: CustomStyleEditData, completion: ((CustomStyle?, NSError?) -> (Void))?) -> RequestHandler {
        return editCustomStyleForUser(userId: userId, withData: data) {
            (customStyle, error) -> (Void) in
            completion?(customStyle, APIClient.errorTypeToNSError(error))
        }
    }

    // MARK: - Activities
    public func _getActivities(pagingData: PagingData?, completion: ((Array<Activity>?, PagingInfo?, NSError?) -> (Void))?) -> RequestHandler {
        return getActivities(pagingData: pagingData) {
            (activities, pInfo, error) -> (Void) in
            completion?(activities, pInfo, APIClient.errorTypeToNSError(error))
        }
    }

    // MARK: - Notifications
    public func _getNotifications(pagingdata: PagingData?, completion: ((Array<Notification>?, Array<Notification>?, _ newNotificationsCount: Int?, _ unreadNotificationsCount: Int?, _ hasUnreadNotifications: Bool?, PagingInfo?, NSError?) -> (Void))?) -> RequestHandler {
        return getNotifications(pagingData: pagingdata) {
            (responseData: ResponseData<Notification>?, newNotificationsCount: Int?, unreadNotificationsCount: Int?, hasUnreadNotifications: Bool?) -> (Void) in
            completion?(responseData?.objects, responseData?.rejectedObjects, newNotificationsCount, unreadNotificationsCount, hasUnreadNotifications, responseData?.pagingInfo, APIClient.errorTypeToNSError(responseData?.error))
        }
    }

    public func _markNotificationAsRead(notificationId: String, completion: ((NSError?) -> (Void))?) -> RequestHandler {
        return markNotificationAsRead(notificationId: notificationId) {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }

    public func _trackWhenNotificationsWereViewed(completion: ((NSError?) -> (Void))?) -> RequestHandler {
        return trackWhenNotificationsWereViewed {
                (error) -> (Void) in
                completion?(APIClient.errorTypeToNSError(error))
        }
    }

    // MARK: - User Followings
    public func _createUserFollowing(userId: String, completion: ((NSError?) -> (Void))?) -> RequestHandler {
        return createUserFollowing(userId: userId) {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }

    public func _deleteUserFollowing(userId: String, completion: ((NSError?) -> (Void))?) -> RequestHandler {
        return deleteAUserFollowing(userId: userId) {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }

    // MARK: - Partner Applications
    public func _getPartnerApplication(id: String, completion: ((PartnerApplication?, NSError?) -> (Void))?) -> RequestHandler {
        return getPartnerApplication(id) {
            (partnerApplication, error) -> (Void) in
            completion?(partnerApplication, APIClient.errorTypeToNSError(error))
        }
    }

    public func _searchPartnerApplications(query: String, completion: ((Array<PartnerApplication>?, NSError?) -> (Void))?) -> RequestHandler {
        return searchPartnerApplications(query) {
            (partnerApplications, error) -> (Void) in
            completion?(partnerApplications, APIClient.errorTypeToNSError(error))
        }
    }

    // MARK: - Avatar
    public func _getSuggestedAvatars(completion: ((Array<AvatarSuggestion>?, NSError?) -> (Void))?) -> RequestHandler {
        return getSuggestedAvatars {
                (suggestedAvatars, error) -> (Void) in
                completion?(suggestedAvatars, APIClient.errorTypeToNSError(error))
        }
    }

    public func _updateUserAvatar(userId: String, data: UpdateAvatarData, completion: ((NSError?) -> (Void))?) -> RequestHandler {
        return updateUserAvatar(userId: userId, data: data) {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }

    // MARK: - Utils
    static func errorTypeToNSError(_ error: Error?) -> NSError? {
        if let error = error as? APIClientError {
            let userInfo = [NSLocalizedDescriptionKey: error.title]
            return NSError(domain: APIClientError.DefaultDomain, code: error.status, userInfo: userInfo)
        }
        if let error = error as NSError? {
            return error
        }
        if let _ = error {
            let userInfo = [NSLocalizedDescriptionKey: String(describing: error)]
            return NSError(domain: APIClientError.DefaultDomain, code: APIClientError.UnknownStatus, userInfo: userInfo)
        }
        return nil
    }
}
