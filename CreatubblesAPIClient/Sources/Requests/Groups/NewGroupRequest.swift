//
//  NewGroupRequest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 14.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class NewGroupRequest: Request
{
    override var method: RequestMethod   { return .post }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    override var endpoint: String { return "groups" }
    fileprivate let data: NewGroupData
    
    init(data: NewGroupData)
    {
        self.data = data
    }
    
    fileprivate func prepareParameters() -> Dictionary<String, AnyObject>
    {
        var dataDict = Dictionary<String, AnyObject>()
        var attributesDict = Dictionary<String, AnyObject>()
        var relationshipsDict = Dictionary<String, AnyObject>()
        
        dataDict["type"] = "groups" as AnyObject?
        attributesDict["name"] = data.name as AnyObject?
        
        if let value = data.avatarCreationIdentifier { relationshipsDict["avatar_creation"] = ["data" : ["id" : value]] }
        
        dataDict["attributes"] = attributesDict as AnyObject?
        dataDict["relationships"] = relationshipsDict as AnyObject?
        
        return ["data" : dataDict as AnyObject]
    }
}
