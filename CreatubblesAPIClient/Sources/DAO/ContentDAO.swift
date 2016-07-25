//
//  ContentDAO.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 19.05.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class ContentDAO: NSObject
{
    private let requestSender: RequestSender
    
    init(requestSender: RequestSender)
    {
        self.requestSender = requestSender
    }
    
    func getTrendingContent(pagingData pagingData: PagingData?, completion: ContentEntryClosure?) -> RequestHandler
    {
        let request = ContentRequest(type: .Trending, page: pagingData?.page, perPage: pagingData?.pageSize)
        let handler = ContentResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func getRecentContent(pagingData pagingData: PagingData?, completion: ContentEntryClosure?) -> RequestHandler
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
    
    func getMyConnectionsContent(pagingData pagingData: PagingData?,  completion: ContentEntryClosure?) -> RequestHandler
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
    
    func getSearchedContents(query query: String, pagingData: PagingData?, completion: ContentEntryClosure?) -> RequestHandler
    {
        let request = ContentSearchRequest(query: query, page: pagingData?.page, perPage: pagingData?.pageSize)
        let handler = ContentSearchResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
}
