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
    
    func getBubblesForCreationWithIdentifier(identifier: String, completion: BubblesClousure?)
    {
        let request = BubblesFetchReqest(creationId: identifier)
        let handler = BubblesFetchResponseHandler(completion: completion)
        requestSender.send(request, withResponseHandler: handler)
    }
    
    func getBubblesForUserWithIdentifier(identifier: String, completion: BubblesClousure)
    {
        let request = BubblesFetchReqest(userId: identifier)
        let handler = BubblesFetchResponseHandler(completion: completion)
        requestSender.send(request, withResponseHandler: handler)
    }
    
    func getBubblesForGalleryWithIdentifier(identifier: String, completion: BubblesClousure)
    {
        let request = BubblesFetchReqest(galleryId: identifier)
        let handler = BubblesFetchResponseHandler(completion: completion)
        requestSender.send(request, withResponseHandler: handler)
    }
    
    func newBubble(data: NewBubbleData, completion: ErrorClousure?)
    {
        let request = NewBubbleRequest(data: data)
        let handler = NewBubbleResponseHandler(completion: completion)
        requestSender.send(request, withResponseHandler: handler)
    }
    
    func updateBubble(data: UpdateBubbleData, completion: ErrorClousure?)
    {
        let request = UpdateBubbleRequest(data: data)
        let handler = UpdateBubbleResponseHandler(completion: completion)
        requestSender.send(request, withResponseHandler: handler)
    }
    
    func deleteBubble(bubbleId: String, completion: ErrorClousure?)
    {
        let request = DeleteBubbleRequest(bubbleId: bubbleId)
        let handler = DeleteBubbleResponseHandler(completion: completion)
        requestSender.send(request, withResponseHandler: handler)
    }

}
