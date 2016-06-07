//
//  BubbleDAO.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 17.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class BubbleDAO: NSObject
{
    private let requestSender: RequestSender
    
    init(requestSender: RequestSender)
    {
        self.requestSender = requestSender
    }
    
    func getBubblesForCreationWithIdentifier(identifier: String, pagingData: PagingData?, completion: BubblesClousure?) -> RequestHandler
    {
        let request = BubblesFetchReqest(creationId: identifier, page: pagingData?.page, perPage: pagingData?.pageSize)
        let handler = BubblesFetchResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getBubblesForUserWithIdentifier(identifier: String, pagingData: PagingData?, completion: BubblesClousure) -> RequestHandler
    {
        let request = BubblesFetchReqest(userId: identifier, page: pagingData?.page, perPage: pagingData?.pageSize)
        let handler = BubblesFetchResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getBubblesForGalleryWithIdentifier(identifier: String, pagingData: PagingData?, completion: BubblesClousure) -> RequestHandler
    {
        let request = BubblesFetchReqest(galleryId: identifier, page: pagingData?.page, perPage: pagingData?.pageSize)
        let handler = BubblesFetchResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func newBubble(data: NewBubbleData, completion: BubbleClousure?) -> RequestHandler
    {
        let request = NewBubbleRequest(data: data)
        let handler = NewBubbleResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func updateBubble(data: UpdateBubbleData, completion: BubbleClousure?) -> RequestHandler
    {
        let request = UpdateBubbleRequest(data: data)
        let handler = UpdateBubbleResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func deleteBubble(bubbleId: String, completion: ErrorClosure?) -> RequestHandler
    {
        let request = DeleteBubbleRequest(bubbleId: bubbleId)
        let handler = DeleteBubbleResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }

}
