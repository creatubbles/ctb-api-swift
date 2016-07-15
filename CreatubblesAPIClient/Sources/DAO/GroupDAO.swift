//
//  GroupDAO.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 14.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class GroupDAO: NSObject
{
    private let requestSender: RequestSender
    
    init(requestSender: RequestSender)
    {
        self.requestSender = requestSender
    }
    
    func fetchGroupWithIdentifier(identifier: String, completion: GroupClosure?) -> RequestHandler
    {
        let request = GroupsRequest(groupId: identifier)
        let handler = GroupResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func fetchGroups(completion: GroupsClosure?) -> RequestHandler
    {
        let request = GroupsRequest()
        let handler = GroupsResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func newGroup(data: NewGroupData, completion: GroupClosure?) -> RequestHandler
    {
        let request = NewGroupRequest(data: data)
        let handler = NewGroupResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func editGroup(identifier: String, data: EditGroupData, completion: ErrorClosure?) -> RequestHandler
    {
        let request = EditGroupRequest(identifier: identifier, data: data)
        let handler = EditGroupResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func deleteGroup(identifier: String, completion: ErrorClosure?) -> RequestHandler
    {
        let request = DeleteGroupRequest(identifier: identifier)
        let handler = DeleteGroupResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }    
}