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
