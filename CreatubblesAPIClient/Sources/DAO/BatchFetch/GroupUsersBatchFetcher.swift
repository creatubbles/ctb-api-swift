//
//  GroupUsersBatchFetcher.swift
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

class GroupUsersBatchFetcher: BatchFetcher {
    fileprivate var groupId: String!
    fileprivate var users = Array<User>()
    
    fileprivate var currentRequest: GroupCreatorsRequest {
        return GroupCreatorsRequest(groupId: groupId, page: page, perPage: perPage)
    }
    
    fileprivate func responseHandler(_ completion: UsersBatchClosure?) -> GroupCreatorsResponseHandler {
        return GroupCreatorsResponseHandler() { (users, pagingInfo, error) -> (Void) in
                if let error = error {
                    completion?(self.users, error)
                } else {
                    if let users = users {
                        self.users.append(contentsOf: users)
                    }
                    
                    if let pagingInfo = pagingInfo {
                        if(pagingInfo.totalPages > self.page && self.page < self.maxPageCount) {
                            self.page += 1
                            _ = self.requestSender.send(self.currentRequest, withResponseHandler: self.responseHandler(completion))
                        } else {
                            completion?(self.users, error)
                        }
                    }
                }
        }
    }
    
    func fetch(_ groupId: String, completion: UsersBatchClosure?) -> RequestHandler {
        self.groupId = groupId
        return requestSender.send(currentRequest, withResponseHandler: responseHandler(completion))
    }
}
