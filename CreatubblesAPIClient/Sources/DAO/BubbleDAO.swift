//
//  BubbleDAO.swift
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
//


import UIKit

class BubbleDAO: NSObject
{
    fileprivate let requestSender: RequestSender
    
    init(requestSender: RequestSender)
    {
        self.requestSender = requestSender
    }
    
    func getBubbles(creationIdentifier identifier: String, pagingData: PagingData?, completion: BubblesClousure?) -> RequestHandler
    {
        let request = BubblesFetchReqest(creationId: identifier, page: pagingData?.page, perPage: pagingData?.pageSize)
        let handler = BubblesFetchResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getBubbles(userIdentifier identifier: String, pagingData: PagingData?, completion: @escaping BubblesClousure) -> RequestHandler
    {
        let request = BubblesFetchReqest(userId: identifier, page: pagingData?.page, perPage: pagingData?.pageSize)
        let handler = BubblesFetchResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getBubbles(galleryIdentifier identifier: String, pagingData: PagingData?, completion: @escaping BubblesClousure) -> RequestHandler
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
    
    func deleteBubble(bubbleIdentifier bubbleId: String, completion: ErrorClosure?) -> RequestHandler
    {
        let request = DeleteBubbleRequest(bubbleId: bubbleId)
        let handler = DeleteBubbleResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }

}
