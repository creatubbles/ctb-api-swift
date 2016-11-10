
//
//  AvatarDAO.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 10.11.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class AvatarDAO: NSObject
{
    fileprivate let requestSender: RequestSender
    
    init(requestSender: RequestSender)
    {
        self.requestSender = requestSender
    }
    
    open func getSuggestedAvatars(completion: AvatarSuggestionsClosure?) -> RequestHandler
    {
        let request = AvatarSuggestionsFetchRequest()
        let handler = AvatarSuggestionsFetchResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
    
    open func updateUserAvatar(userId: String, data: UpdateAvatarData, completion: ErrorClosure?) -> RequestHandler
    {
        let request = UserAvatarUpdateRequest(userId: userId, data: data)
        let handler = UserAvatarUpdateResponseHandler(completion: completion)
        return requestSender.send(request, withResponseHandler: handler)
    }
}
