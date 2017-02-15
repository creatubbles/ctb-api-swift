//
//  ContentDAO.swift
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

class ContentDAO: NSObject, APIClientDAO
{
    fileprivate let requestSender: RequestSender
    
    init(requestSender: RequestSender)
    {
        self.requestSender = requestSender
    }
    
    func getTrendingContent(pagingData: PagingData?, completion: ContentEntryClosure?) -> RequestHandler
    {
        let request = ContentRequest(type: .Trending, page: pagingData?.page, perPage: pagingData?.pageSize)
        let handler = ContentResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getRecentContent(pagingData: PagingData?, completion: ContentEntryClosure?) -> RequestHandler
    {
        let request = ContentRequest(type: .Recent, page: pagingData?.page, perPage: pagingData?.pageSize)
        let handler = ContentResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getUserBubbledContent(userIdentifier userId: String, pagingData: PagingData?, completion: ContentEntryClosure?) -> RequestHandler
    {
        let request = ContentRequest(type: .BubbledContents, page: pagingData?.page, perPage: pagingData?.pageSize, userId: userId)
        let handler = ContentResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getMyConnectionsContent(pagingData: PagingData?,  completion: ContentEntryClosure?) -> RequestHandler
    {
        let request = ContentRequest(type: .Connected, page: pagingData?.page, perPage: pagingData?.pageSize)
        let handler = ContentResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getContentsByAUser(userIdentfier userId: String, pagingData: PagingData?, completion: ContentEntryClosure?) -> RequestHandler
    {
        let request = ContentRequest(type: .ContentsByAUser, page: pagingData?.page, perPage: pagingData?.pageSize, userId: userId)
        let handler = ContentResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getFollowedContents(_ pagingData: PagingData?, completion: ContentEntryClosure?) -> RequestHandler
    {
        let request = ContentRequest(type: .Followed, page: pagingData?.page, perPage: pagingData?.pageSize)
        let handler = ContentResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getSearchedContents(query: String, pagingData: PagingData?, completion: ContentEntryClosure?) -> RequestHandler
    {
        let request = ContentSearchRequest(query: query, page: pagingData?.page, perPage: pagingData?.pageSize)
        let handler = ContentSearchResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
}
