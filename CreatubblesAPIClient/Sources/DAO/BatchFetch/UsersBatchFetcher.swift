//
//  UsersBatchFetcher.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 26.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class UsersBatchFetcher: BatchFetcher
{
    private var userId: String?
    private var scope: CreatorsAndManagersScopeElement?
    private var allUsers = Array<User>()
    
    private var currentRequest: CreatorsAndManagersRequest
    {
        return CreatorsAndManagersRequest(userId: userId, page: page, perPage: perPage, scope: scope)
    }
    
    private func responseHandler(completion: UsersBatchClousure?) -> CreatorsAndManagersResponseHandler
    {
        return CreatorsAndManagersResponseHandler()
        {
            (users, pInfo, error) -> (Void) in
            if let error = error
            {
                completion?(self.allUsers, error)
            }
            else
            {
                if let users = users
                {
                    self.allUsers.appendContentsOf(users)
                }
                if let pInfo = pInfo
                {
                    if(pInfo.totalPages > self.page && self.page < self.maxPageCount)
                    {
                        self.page += 1
                        self.requestSender.send(self.currentRequest, withResponseHandler: self.responseHandler(completion))
                    }
                    else
                    {
                        completion?(self.allUsers, error)
                    }
                }
            }
        }
    }
    
    func fetch(userId: String?, scope:CreatorsAndManagersScopeElement?, completion: UsersBatchClousure?)
    {
        self.userId = userId
        self.scope = scope
        requestSender.send(currentRequest, withResponseHandler: responseHandler(completion))
    }
}