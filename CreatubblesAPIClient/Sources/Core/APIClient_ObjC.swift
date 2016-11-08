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
    public func _login(username: String, password: String, completion: ((NSError?) -> (Void))?)
    {
        login(username: username, password: password)
        {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
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
    
    public func _getLandingURL(type: LandingURLType, completion: ((Array<LandingURL>? ,NSError?) -> (Void))?)
    {
        getLandingURL(type: type)
        {
            (landingUrls, error) -> (Void) in
            completion?(landingUrls, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getLandingURLForCreation(creationId: String, completion: ((Array<LandingURL>? ,NSError?) -> (Void))?)
    {
        getLandingURL(creationId: creationId)
        {
            (landingUrls, error) -> (Void) in
            completion?(landingUrls, APIClient.errorTypeToNSError(error))
        }
    }
    
    //MARK: - Users handling
    public func _getUser(userId: String, completion: ((User?, NSError?) -> (Void))?)
    {
        getUser(userId: userId)
        {
            (user, error) -> (Void) in
            completion?(user, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getCurrentUser(completion: ((User?, NSError?) -> (Void))?)
    {
        getCurrentUser()
        {
            (user, error) -> (Void) in
            completion?(user, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _switchUser(targetUserId: String, accessToken: String, completion: ((String?, NSError?) -> (Void))?)
    {
        switchUser(targetUserId: targetUserId, accessToken: accessToken)
        {
            (accessToken, error) -> (Void) in
            completion?(accessToken, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _reportUser(userId: String, message: String, completion: ((NSError?) -> (Void))?)
    {
        reportUser(userId: userId, message: message)
        {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getCreators(userId userId: String?, pagingData: PagingData?, completion: ((Array<User>?,PagingInfo? ,NSError?) -> (Void))?)
    {
        getCreators(userId: userId, pagingData: pagingData)
        {
            (users, pInfo, error) -> (Void) in
            completion?(users, pInfo, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getCreators(groupId groupId: String, pagingData: PagingData?, completion: ((Array<User>?,PagingInfo? ,NSError?) -> (Void))?)
    {
        getCreators(groupId: groupId, pagingData: pagingData)
        {
            (users, pInfo, error) -> (Void) in
            completion?(users, pInfo, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getSwitchUsers(pagingData: PagingData?, completion: ((Array<User>?,PagingInfo? ,NSError?) -> (Void))?)
    {
        getSwitchUsers(pagingData)
        {
            (users, pInfo, error) -> (Void) in
            completion?(users, pInfo, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getManagers(userId: String?, pagingData: PagingData?, completion: ((Array<User>?,PagingInfo?, NSError?) -> (Void))?)
    {
        getManagers(userId: userId, pagingData: pagingData)
        {
            (users, pInfo, error) -> (Void) in
            completion?(users, pInfo, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _newCreator(creatorData: NewCreatorData, completion: ((User?, NSError?) -> (Void))?)
    {
        newCreator(data: creatorData)
        {
            (user, error) -> (Void) in
            completion?(user, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getGroupCreatorsInBatchMode(groupId: String, completion: ((Array<User>?, NSError?) -> (Void))?)
    {
        getGroupCreatorsInBatchMode(groupId: groupId)
        {
            (users, error) -> (Void) in
            completion?(users, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _editProfile(identifier: String, data: EditProfileData, completion: ((NSError?) -> (Void))?)
    {
        editProfile(userId: identifier, data: data)
        {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }

    public func _createMultipleCreators(data: CreateMultipleCreatorsData, completion: ((NSError?) -> (Void))?)
    {
        createMultipleCreators(data: data)
        {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getMyConnections(pagingData: PagingData?, completion: ((Array<User>?,PagingInfo? ,NSError?) -> (Void))?)
    {
        getMyConnections(pagingData: pagingData)
        {
            (users, pInfo, error) -> (Void) in
            completion?(users, pInfo, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getOtherUsersMyConnections(userId: String, pagingData: PagingData?, completion: ((Array<User>?,PagingInfo? ,NSError?) -> (Void))?)
    {
        getOtherUsersMyConnections(userId: userId, pagingData: pagingData)
        {
            (users, pInfo, error) -> (Void) in
            completion?(users, pInfo, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getUsersFollowedByAUser(userId: String, pagingData: PagingData?, completion: ((Array<User>?,PagingInfo? ,NSError?) -> (Void))?)
    {
        getUsersFollowedByAUser(userId: userId, pagingData: pagingData)
        {
            (users, pInfo, error) -> (Void) in
            completion?(users, pInfo, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getUserAccountData(userId: String, completion: ((UserAccountDetails?, NSError?) -> (Void))?)
    {
        getUserAccountData(userId: userId)
        {
            (userAccountDetails, error) -> (Void) in
            completion?(userAccountDetails, APIClient.errorTypeToNSError(error))
        }
    }
    
    //MARK: - Gallery handling
    public func _getGallery(galleryId: String, completion: ((Gallery?, NSError?) -> (Void))?)
    {
        getGallery(galleryId: galleryId)
        {
            (gallery, error) -> (Void) in
            completion?(gallery, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _newGallery(galleryData: NewGalleryData, completion: ((Gallery?, NSError?) -> (Void))?)
    {
        newGallery(data: galleryData)
        {
            (gallery, error) -> (Void) in
            completion?(gallery, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getGalleries(userId: String?, pagingData: PagingData?, sort: SortOrder, completion: ((Array<Gallery>?, PagingInfo?, NSError?) -> (Void))?)
    {
        getGalleries(userId: userId, pagingData: pagingData, sort: sort)
        {
            (galleries, pInfo, error) -> (Void) in
            completion?(galleries, pInfo, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getGalleries(creationId: String, pagingData: PagingData?, sort: SortOrder?, completion: ((Array<Gallery>?, PagingInfo?, NSError?) -> (Void))?)
    {
        getGalleries(creationId: creationId, pagingData: pagingData, sort: sort)
        {
            (galleries, pInfo, error) -> (Void) in
            completion?(galleries, pInfo, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getMyGalleries(pagingData: PagingData?,  completion: ((Array<Gallery>?, PagingInfo?, NSError?) -> (Void))?)
    {
        getMyGalleries(pagingData)
        {
            (galleries, pInfo, error) -> (Void) in
            completion?(galleries, pInfo, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getMyOwnedGalleries(pagingData: PagingData?, completion: ((Array<Gallery>?, PagingInfo?, NSError?) -> (Void))?)
    {
        getMyOwnedGalleries(pagingData)
        {
            (galleries, pInfo, error) -> (Void) in
            completion?(galleries, pInfo, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getMySharedGalleries(pagingData: PagingData?,  completion: ((Array<Gallery>?, PagingInfo?, NSError?) -> (Void))?)
    {
        getMySharedGalleries(pagingData)
        {
            (galleries, pInfo, error) -> (Void) in
            completion?(galleries, pInfo, APIClient.errorTypeToNSError(error))
        }
    }


    public func _getMyFavoriteGalleries(pagingData: PagingData?, completion: ((Array<Gallery>?, PagingInfo?, NSError?) -> (Void))?)
    {
        getMyFavoriteGalleries(pagingData)
        {
            (galleries, pInfo, error) -> (Void) in
            completion?(galleries, pInfo, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getFeaturedGalleries(pagingData: PagingData?, completion: ((Array<Gallery>?, PagingInfo?, NSError?) -> (Void))?)
    {
        getFeaturedGalleries(pagingData)
        {
            (galleries, pInfo, error) -> (Void) in
            completion?(galleries, pInfo, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getMyGalleriesInBatchMode(completion: ((Array<Gallery>?, NSError?) -> (Void))?)
    {
        getMyGalleriesInBatchMode()
        {
            (galleries, error) -> (Void) in
            completion?(galleries, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getOwnedGalleriesInBatchMode(completion: ((Array<Gallery>?, NSError?) -> (Void))?)
    {
        getOwnedGalleriesInBatchMode()
        {
            (galleries, error) -> (Void) in
            completion?(galleries, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getSharedGalleriesInBatchMode(completion: ((Array<Gallery>?, NSError?) -> (Void))?)
    {
        getSharedGalleriesInBatchMode()
        {
            (galleries, error) -> (Void) in
            completion?(galleries, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getFavoriteGalleriesInBatchMode(completion: ((Array<Gallery>?, NSError?) -> (Void))?)
    {
        getFavoriteGalleriesInBatchMode()
        {
            (galleries, error) -> (Void) in
            completion?(galleries, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getFeaturedGalleriesInBatchMode(completion: ((Array<Gallery>?, NSError?) -> (Void))?)
    {
        getFeaturedGalleriesInBatchMode()
        {
            (galleries, error) -> (Void) in
            completion?(galleries, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _updateGallery(data: UpdateGalleryData, completion:  ((NSError?) -> (Void))?)
    {
        updateGallery(data: data)
        {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }
 
    public func _reportGallery(galleryId: String, message: String, completion: ((NSError?) -> (Void))?)
    {
        reportGallery(galleryId: galleryId, message: message)
        {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }

    public func _submitCreationToGallery(galleryId: String, creationId: String, completion: ((NSError?) -> (Void))?)
    {
        submitCreationToGallery(galleryId: galleryId, creationId: creationId)
        {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }
    
    //MARK: - Creation handling
    public func _getCreation(creationId: String, completion: ((Creation?, NSError?) -> (Void))?)
    {
        getCreation(creationId: creationId)
        {
            (creation, error) -> (Void) in
            completion?(creation, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getCreations(galleryId: String, userId: String?, keyword: String?, pagingData: PagingData?, sortOrder: SortOrder, onlyPublic: Bool, completion: ((Array<Creation>?, PagingInfo?, NSError?) -> (Void))?)
    {
        getCreations(galleryId: galleryId, userId: userId, keyword: keyword, pagingData: pagingData, sortOrder: sortOrder, onlyPublic: onlyPublic)
        {
            (creations, pInfo, error) -> (Void) in
            completion?(creations, pInfo, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _newCreation(creationData: NewCreationData, completion: ((Creation?, NSError?) -> (Void))?)
    {
        newCreation(data: creationData)
        {
            (creation, error) -> (Void) in
            completion?(creation, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _reportCreation(creationId: String, message: String, completion: ((NSError?) -> (Void))?)
    {
        reportCreation(creationId: creationId, message: message)
        {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }

    public func _getRecommendedCreationsByUser(userId: String, pagingData: PagingData?, completion: ((Array<Creation>?, PagingInfo?, NSError?) -> (Void))?)
    {
        getRecomendedCreationsByUser(userId: userId, pagingData: pagingData)
        {
            (creations, pInfo, error) -> (Void) in
            completion?(creations, pInfo, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getRecommendedCreationsByCreation(creationId: String, pagingData: PagingData?, completion: ((Array<Creation>?, PagingInfo?, NSError?) -> (Void))?)
    {
        getRecomendedCreationsByCreation(creationId: creationId, pagingData: pagingData)
        {
            (creations, pInfo, error) -> (Void) in
            completion?(creations, pInfo, APIClient.errorTypeToNSError(error))
        }
    }

    public func _editCreation(creationId: String, data: EditCreationData, completion: ((NSError?) -> (Void))?)
    {
        editCreation(creationId: creationId, data: data)
        {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _removeCreation(creationId: String, completion: ((NSError?) -> (Void))?)

    {
        removeCreation(creationId: creationId)
        {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }
    
    //MARK: - Batch fetching
    public func _getCreationsInBatchMode(galleryId: String?, userId: String?, keyword: String?, sortOrder: SortOrder, onlyPublic: Bool, completion: ((Array<Creation>?, NSError?) -> (Void))?)
    {
        getCreationsInBatchMode(galleryId: galleryId, userId: userId, keyword: keyword, sortOrder: sortOrder, onlyPublic: onlyPublic)
        {
            (creations, error) -> (Void) in
            completion?(creations, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getGalleriesInBatchMode(userId: String?, sort: SortOrder, completion: ((Array<Gallery>?, NSError?) -> (Void))?)
    {
        getGalleriesInBatchMode(userId: userId, sort: sort)
        {
            (galleries, error) -> (Void) in
            completion?(galleries, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getCreatorsInBatchMode(userId: String?, completion: ((Array<User>?,NSError?) -> (Void))?)
    {
        getCreatorsInBatchMode(userId: userId)
        {
            (users, error) -> (Void) in
            completion?(users, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getManagersInBatchMode(userId: String?, completion: ((Array<User>?,NSError?) -> (Void))?)
    {
        getManagersInBatchMode(userId: userId)
        {
            (users, error) -> (Void) in
            completion?(users, APIClient.errorTypeToNSError(error))
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
    
    public func _startAllNotFinishedUploadSessions(completion: ((Creation?, NSError?) -> (Void))?)
    {
        startAllNotFinishedUploadSessions {
            (creation, error) -> (Void) in
            completion?(creation, APIClient.errorTypeToNSError(error))
        }
    }
    
    //MARK: - Bubbles
    public func _getBubblesForCreationWithIdentifier(identifier: String, pagingData: PagingData?, completion: ((Array<Bubble>?, PagingInfo?, NSError?) -> (Void))?)
    {
        getBubbles(creationId: identifier, pagingData: pagingData)
        {
            (bubbles, pInfo, error) -> (Void) in
            completion?(bubbles, pInfo, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getBubblesForUserWithIdentifier(identifier: String, pagingData: PagingData?, completion: ((Array<Bubble>?,PagingInfo?, NSError?) -> (Void))?)
    {
        getBubbles(userId: identifier, pagingData: pagingData)
        {
            (bubbles, pInfo, error) -> (Void) in
            completion?(bubbles, pInfo, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _getBubblesForGalleryWithIdentifier(identifier: String, pagingData: PagingData?, completion: ((Array<Bubble>?, PagingInfo?, NSError?) -> (Void))?)
    {
        getBubbles(galleryId: identifier, pagingData: pagingData)
        {
            (bubbles, pInfo, error) -> (Void) in
            completion?(bubbles, pInfo, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _newBubble(data: NewBubbleData, completion: ((Bubble?, NSError?) -> (Void))?)
    {
        newBubble(data: data)
        {
            (bubble, error) -> (Void) in
            completion?(bubble, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _updateBubble(data: UpdateBubbleData, completion: ((Bubble?, NSError?) -> (Void))?)
    {
        updateBubble(data: data)
        {
            (bubble, error) -> (Void) in
            completion?(bubble, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _deleteBubble(bubbleId: String, completion: ((NSError?) -> (Void))?)
    {
        deleteBubble(bubbleId: bubbleId)
        {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }
    
    //MARK: - Toyboo Creation
    public func _getToybooCreation(creationId: String, completion: ((ToybooCreation?, NSError?) -> (Void))?)
    {
        getToybooCreation(creationId: creationId)
        {
            (toybooCreation, error) -> (Void) in
            completion?(toybooCreation, APIClient.errorTypeToNSError(error) )
        }
    }
    
    //MARK: - Groups
    public func _fetchGroup(groupId: String, completion: ((Group?, NSError?) -> (Void))?)
    {
        fetchGroup(groupId: groupId)
        {
            (group, error) -> (Void) in
            completion?(group, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _fetchGroups(completion: ((Array<Group>?, NSError?) -> (Void))?)
    {
        fetchGroups()
        {
            (groups, errors) -> (Void) in
            completion?(groups, APIClient.errorTypeToNSError(errors))
        }
    }
    
    public func _newGroup(data: NewGroupData, completion: ((Group?, NSError?) -> (Void))?)
    {
        newGroup(data: data)
        {
            (group, error) -> (Void) in
            completion?(group, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _editGroup(groupId: String, data: EditGroupData, completion: ((NSError?) -> (Void))?)
    {
        editGroup(groupId: groupId, data: data)
        {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }

    public func _deleteGroup(groupId: String, completion: ((NSError?) -> (Void))?)
    {
        deleteGroup(groupId: groupId)
        {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }
    
    //MARK: - Comments
    public func _addComment(data: NewCommentData, completion: ((NSError?) -> (Void))?)
    {
        addComment(data: data)
        {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _reportComment(commentId: String, message: String, completion: ((NSError?) -> (Void))?)
    {
        reportComment(commentId: commentId, message: message)
        {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }

    public func _getComments(creationId creationId: String, pagingData: PagingData?, completion: ((Array<Comment>?, PagingInfo?, NSError?) -> (Void))?)
    {
        getComments(creationId: creationId, pagingData: pagingData)
        {
            (comments, pInfo, error) -> (Void) in
            completion?(comments, pInfo, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getComments(userId userId: String, pagingData: PagingData?, completion: ((Array<Comment>?, PagingInfo?, NSError?) -> (Void))?)
    {
        getComments(userId: userId, pagingData: pagingData)
        {
            (comments, pInfo, error) -> (Void) in
            completion?(comments, pInfo, APIClient.errorTypeToNSError(error))
        }
    }

    public func _getComments(galleryId galleryId: String, pagingData: PagingData?, completion: ((Array<Comment>?, PagingInfo?, NSError?) -> (Void))?)
    {
        getComments(galleryId: galleryId, pagingData: pagingData)
        {
            (comments, pInfo, error) -> (Void) in
            completion?(comments, pInfo, APIClient.errorTypeToNSError(error))
        }
    }
    
    //MARK: - Contents
    public func _getTrendingContent(pagingData: PagingData?, completion: ((ResponseData<ContentEntry>) -> (Void))?)
    {
        getTrendingContent(pagingData: pagingData)
        {
            (contentEntries) -> (Void) in
            completion?(contentEntries)
        }
    }
    
    public func _getRecentContent(pagingData: PagingData?, completion: ((ResponseData<ContentEntry>) -> (Void))?)
    {
        getRecentContent(pagingData: pagingData)
        {
            (contentEntries) -> (Void) in
            completion?(contentEntries)
        }
    }
    
    public func _getBubbledContent(userId: String, pagingData: PagingData?, completion: ((ResponseData<ContentEntry>) -> (Void))?)
    {
        getBubbledContent(userId: userId, pagingData: pagingData)
        {
            (contentEntries) -> (Void) in
            completion?(contentEntries)
        }
    }

    public func _getMyConnectionsContent(pagingData: PagingData?, completion: ((ResponseData<ContentEntry>) -> (Void))?)
    {
        getMyConnectionsContent(pagingData: pagingData)
        {
            (contentEntries) -> (Void) in
            completion?(contentEntries)
        }
    }
    
    public func _getContentsByUser(userId: String, pagingData: PagingData?, completion: ((ResponseData<ContentEntry>) -> (Void))?)
    {
        getContentsByAUser(userId: userId, pagingData: pagingData)
        {
            (contentEntries) -> (Void) in
            completion?(contentEntries)
        }
    }
    
    public func _getFollowedContents(pagingData: PagingData?, completion: ((ResponseData<ContentEntry>) -> (Void))?)
    {
        getFollowedContents(pagingData)
        {
            (contentEntries) -> (Void) in
            completion?(contentEntries)
        }
    }
 
    public func _getSearchedContents(query: String, pagingData: PagingData?, completion: ((ResponseData<ContentEntry>) -> (Void))?)
    {
        getSearchedContents(query: query, pagingData: pagingData)
        {
            (contentEntries) -> (Void) in
            completion?(contentEntries)
        }
    }
    
    //Mark: - Custom Style
    public func _fetchCustomStyleForUser(userId: String, completion: ((CustomStyle?, NSError?) -> (Void))?)
    {
        fetchCustomStyleForUser(userId: userId)
        {
            (customStyle, error) -> (Void) in
            completion?(customStyle, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _editCustomStyleForUser(userId: String, data: CustomStyleEditData, completion: ((CustomStyle?, NSError?) -> (Void))?)
    {
        editCustomStyleForUser(userId: userId, withData: data)
        {
            (customStyle, error) -> (Void) in
            completion?(customStyle, APIClient.errorTypeToNSError(error))
        }
    }
    
    // MARK: - Activities
    public func _getActivities(pagingData: PagingData?, completion: ((Array<Activity>?, PagingInfo?, NSError?) -> (Void))?)
    {
        getActivities(pagingData: pagingData)
        {
            (activities, pInfo, error) -> (Void) in
            completion?(activities, pInfo, APIClient.errorTypeToNSError(error))
        }
    }
    
    //MARK: - Notifications
    public func _getNotifications(pagingdata: PagingData?, completion: ((Array<Notification>?, unreadNotificationsCount: Int?, PagingInfo?, NSError?) -> (Void))?)
    {
        getNotifications(pagingData: pagingdata)
        {
            (notifications, unreadNotificationsCount, pInfo, error) -> (Void) in
            completion?(notifications, unreadNotificationsCount: unreadNotificationsCount, pInfo, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _markNotificationAsRead(notificationId: String, completion: ((NSError?) -> (Void))?)
    {
        markNotificationAsRead(notificationId: notificationId)
        {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }

    public func _trackWhenNotificationsWereViewed(completion: ((NSError?) -> (Void))?)
    {
        trackWhenNotificationsWereViewed()
        {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }
    
    //MARK: - User Followings
    public func _createUserFollowing(userId: String, completion: ((NSError?) -> (Void))?)
    {
        createUserFollowing(userId: userId)
        {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _deleteUserFollowing(userId: String, completion: ((NSError?) -> (Void))?)
    {
        deleteAUserFollowing(userId: userId)
        {
            (error) -> (Void) in
            completion?(APIClient.errorTypeToNSError(error))
        }
    }
    
    //MARK: - Partner Applications
    public func _getPartnerApplication(id: String, completion: ((PartnerApplication?, NSError?) -> (Void))?)
    {
        getPartnerApplication(id)
        {
            (partnerApplication, error) -> (Void) in
            completion?(partnerApplication, APIClient.errorTypeToNSError(error))
        }
    }
    
    public func _searchPartnerApplications(query: String, completion: ((Array<PartnerApplication>?, NSError?) -> (Void))?)
    {
        searchPartnerApplications(query)
        {
            (partnerApplications, error) -> (Void) in
            completion?(partnerApplications, APIClient.errorTypeToNSError(error))
        }
    }
    
    //MARK: - Utils
    static func errorTypeToNSError(error: ErrorType?) -> NSError?
    {
        if let error = error as? APIClientError
        {
            let userInfo = [NSLocalizedDescriptionKey : error.title]
            return NSError(domain: APIClientError.DefaultDomain, code: error.status, userInfo: userInfo)
        }
        if let _ = error
        {
            let userInfo = [NSLocalizedDescriptionKey :String(error)]
            return NSError(domain: APIClientError.DefaultDomain, code: APIClientError.UnknownStatus, userInfo: userInfo)
        }
        return nil
    }
    
}