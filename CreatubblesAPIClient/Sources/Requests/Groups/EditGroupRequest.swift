//
//  EditGroupRequest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 14.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class EditGroupRequest: Request
{
    override var method: RequestMethod   { return .put }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    override var endpoint: String { return "groups/\(identifier)" }
    
    fileprivate let data: EditGroupData
    fileprivate let identifier: String
    
    init(identifier: String, data: EditGroupData)
    {
        self.identifier = identifier
        self.data = data
    }
    
    fileprivate func prepareParameters() -> Dictionary<String, AnyObject>
    {
        var dataDict = Dictionary<String, AnyObject>()
        var attributesDict = Dictionary<String, AnyObject>()
        var relationshipsDict = Dictionary<String, AnyObject>()
        
        dataDict["type"] = "groups" as AnyObject?
        if let value = data.name { attributesDict["name"] = value as AnyObject? }
        if let value = data.avatarCreationIdentifier { relationshipsDict["avatar_creation"] = ["data" : ["id" : value]] }
        
        dataDict["attributes"] = attributesDict as AnyObject?
        dataDict["relationships"] = relationshipsDict as AnyObject?
        
        return ["data" : dataDict as AnyObject]
    }
}
