//
//  CommentsDAO.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 17.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class CommentsDAO: NSObject
{
    private let requestSender: RequestSender
    
    init(requestSender: RequestSender)
    {
        self.requestSender = requestSender
    }
    
    func addComment(commendData data: NewCommentData, completion: ErrorClosure?) -> RequestHandler
    {
        let request = NewCommentRequest(data: data)
        let handler = NewCommentResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func reportComment(commentIdentifier commentId: String, message: String, completion: ErrorClosure?) -> RequestHandler
    {
        let request = ReportCommentRequest(commentId: commentId, message: message)
        let handler = ReportCommentResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getComments(creationIdentifier identifier: String, pagingData: PagingData?, completion: CommentsClosure?) -> RequestHandler
    {
        let request = CommentsRequest(creationId: identifier, page: pagingData?.page, perPage: pagingData?.pageSize)
        let handler = CommentsResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getComments(userIdentifier identifier: String, pagingData: PagingData?, completion: CommentsClosure?) -> RequestHandler
    {
        let request = CommentsRequest(userId: identifier, page: pagingData?.page, perPage: pagingData?.pageSize)
        let handler = CommentsResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getComments(galleryIdentifier identifier: String, pagingData: PagingData?, completion: CommentsClosure?) -> RequestHandler
    {
        let request = CommentsRequest(galleryId: identifier, page: pagingData?.page, perPage: pagingData?.pageSize)
        let handler = CommentsResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
}
