//
//  GroupDAO.swift
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

class GroupDAO: NSObject
{
    fileprivate let requestSender: RequestSender
    
    init(requestSender: RequestSender)
    {
        self.requestSender = requestSender
    }
    
    func fetchGroup(groupIdentifier identifier: String, completion: GroupClosure?) -> RequestHandler
    {
        let request = GroupsRequest(groupId: identifier)
        let handler = GroupResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func fetchGroups(_ completion: GroupsClosure?) -> RequestHandler
    {
        let request = GroupsRequest()
        let handler = GroupsResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func newGroup(newGroupData data: NewGroupData, completion: GroupClosure?) -> RequestHandler
    {
        let request = NewGroupRequest(data: data)
        let handler = NewGroupResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func editGroup(groupIdentifier identifier: String, data: EditGroupData, completion: ErrorClosure?) -> RequestHandler
    {
        let request = EditGroupRequest(identifier: identifier, data: data)
        let handler = EditGroupResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func deleteGroup(groupIdentifier identifier: String, completion: ErrorClosure?) -> RequestHandler
    {
        let request = DeleteGroupRequest(identifier: identifier)
        let handler = DeleteGroupResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }    
}
