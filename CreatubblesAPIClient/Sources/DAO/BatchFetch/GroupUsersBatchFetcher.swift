//
//  GroupUsersBatchFetcher.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 02.09.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class GroupUsersBatchFetcher: BatchFetcher {
    private var groupId: String!
    private var users = Array<User>()
    
    private var currentRequest: GroupCreatorsRequest {
        return GroupCreatorsRequest(groupId: groupId, page: page, perPage: perPage)
    }
    
    private func responseHandler(completion: UsersBatchClosure?) -> GroupCreatorsResponseHandler {
        return GroupCreatorsResponseHandler() { (users, pagingInfo, error) -> (Void) in
                if let error = error {
                    completion?(self.users, error)
                } else {
                    if let users = users {
                        self.users.appendContentsOf(users)
                    }
                    
                    if let pagingInfo = pagingInfo {
                        if(pagingInfo.totalPages > self.page && self.page < self.maxPageCount) {
                            self.page += 1
                            self.requestSender.send(self.currentRequest, withResponseHandler: self.responseHandler(completion))
                        } else {
                            completion?(self.users, error)
                        }
                    }
                }
        }
    }
    
    func fetch(groupId: String, completion: UsersBatchClosure?) -> RequestHandler {
        self.groupId = groupId
        return requestSender.send(currentRequest, withResponseHandler: responseHandler(completion))
    }
}