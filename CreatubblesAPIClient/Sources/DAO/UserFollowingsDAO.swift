//
//  UserFollowingsDAO.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 20.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class UserFollowingsDAO: NSObject
{
    fileprivate let requestSender: RequestSender
    
    init(requestSender: RequestSender)
    {
        self.requestSender = requestSender
    }
    
    func createAUserFollowing(_ userId: String, completion: ErrorClosure?) -> RequestHandler
    {
        let request = CreateAUserFollowingRequest(userId: userId)
        let handler = CreateAUserFollowingResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    func deleteAUserFollowing(_ userId: String, completion: ErrorClosure?) -> RequestHandler
    {
        let request = DeleteAUserFollowingRequest(userId: userId)
        let handler = DeleteAUserFollowingResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
}
