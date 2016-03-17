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
    
    func getCommentsForCreationWithIdentifier(identifier: String, completion: CommentsClosure?)
    {
        let request = CommentsRequest(creationId: identifier)
        let handler = CommentsResponseHandler(completion: completion)
        requestSender.send(request, withResponseHandler: handler)
    }
    func getCommentsForUserWithIdentifier(identifier: String, completion: CommentsClosure?)
    {
        let request = CommentsRequest(userId: identifier)
        let handler = CommentsResponseHandler(completion: completion)
        requestSender.send(request, withResponseHandler: handler)
    }
    func getCommentsForGalleryWithIdentifier(identifier: String, completion: CommentsClosure?)
    {
        let request = CommentsRequest(galleryId: identifier)
        let handler = CommentsResponseHandler(completion: completion)
        requestSender.send(request, withResponseHandler: handler)
    }
}
