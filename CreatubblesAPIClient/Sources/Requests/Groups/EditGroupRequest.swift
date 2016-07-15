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
    override var method: RequestMethod   { return .PUT }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    override var endpoint: String { return "groups/\(identifier)" }
    
    private let data: EditGroupData
    private let identifier: String
    
    init(identifier: String, data: EditGroupData)
    {
        self.identifier = identifier
        self.data = data
    }
    
    private func prepareParameters() -> Dictionary<String, AnyObject>
    {
        var dataDict = Dictionary<String, AnyObject>()
        var attributesDict = Dictionary<String, AnyObject>()
        var relationshipsDict = Dictionary<String, AnyObject>()
        
        dataDict["type"] = "groups"
        if let value = data.name { attributesDict["name"] = value }
        if let value = data.avatarCreationIdentifier { relationshipsDict["avatar_creation"] = ["data" : ["id" : value]] }
        
        dataDict["attributes"] = attributesDict
        dataDict["relationships"] = relationshipsDict
        
        return ["data" : dataDict]
    }
}
