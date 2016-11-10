//
//  UpdateUserAvatarRequest.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 10.11.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class UserAvatarUpdateRequest: Request
{
    override var method: RequestMethod  { return .put }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    override var endpoint: String
    {
        return "users/\(userId)/user_avatar"
    }
    
    fileprivate let userId: String
    fileprivate let data: UpdateAvatarData
    
    init(userId: String, data: UpdateAvatarData)
    {
        self.userId = userId
        self.data = data
    }
    
    fileprivate func prepareParameters() -> Dictionary<String, AnyObject>
    {
        var dataDict = Dictionary<String, AnyObject>()
        var relationshipsDict = Dictionary<String, AnyObject>()
        
        if let value = data.avatarCreationIdentifier { relationshipsDict["avatar_creation"] = ["data" : ["id" : value]] as AnyObject? }
        if let value = data.avatarSuggestionIdentifier { relationshipsDict["avatar_suggestion"] = ["data" : ["id" : value]] as AnyObject? }
        
        dataDict["relationships"] = relationshipsDict as AnyObject?

        return ["data" : dataDict as AnyObject]
    }
}
