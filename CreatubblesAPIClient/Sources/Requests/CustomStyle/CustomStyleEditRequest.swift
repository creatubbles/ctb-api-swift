//
//  CustomStyleEditRequest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 04.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class CustomStyleEditRequest: Request
{
    override var method: RequestMethod   { return .PUT }
    override var endpoint: String        { return "users/\(userIdentifier)/custom_style" }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    
    private let userIdentifier: String
    private let data: CustomStyleEditData
    
    init(userIdentifier: String, data: CustomStyleEditData)
    {
        self.userIdentifier = userIdentifier
        self.data = data
    }
    
    private func prepareParameters() -> Dictionary<String, AnyObject>
    {
        var dataDict = Dictionary<String, AnyObject>()
        var attributesDict = Dictionary<String, AnyObject>()
        var relationshipsDict = Dictionary<String, AnyObject>()
        
        if let value = data.headerBackgroundIdentifier { attributesDict["header_background_id"] = value }
        if let value = data.bodyBackgroundIdentifier   { attributesDict["body_background_id"] = value }
        if let value = data.fontName                   { attributesDict["font"] = value }
        if let value = data.bio                        { attributesDict["bio"] = value }
        if let value = data.bodyColors                 { attributesDict["body_colors"] = value.map({ $0.hexValue() }) }
        if let value = data.headerColors               { attributesDict["header_colors"] = value.map({ $0.hexValue() }) }
        
        if let value = data.headerCreationIdentifier   { relationshipsDict["header_creation"] = ["data" : ["id" : value]] }
        if let value = data.bodyCreationIdentifier     { relationshipsDict["body_creation"]   = ["data" : ["id" : value]] }
            
        dataDict["attributes"] = attributesDict
        dataDict["relationships"] = relationshipsDict
        
        return ["data" : dataDict]
    }
}
