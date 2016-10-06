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
    override var method: RequestMethod   { return .put }
    override var endpoint: String        { return "users/\(userIdentifier)/custom_style" }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    
    fileprivate let userIdentifier: String
    fileprivate let data: CustomStyleEditData
    
    init(userIdentifier: String, data: CustomStyleEditData)
    {
        self.userIdentifier = userIdentifier
        self.data = data
    }
    
    fileprivate func prepareParameters() -> Dictionary<String, AnyObject>
    {
        var dataDict = Dictionary<String, AnyObject>()
        var attributesDict = Dictionary<String, AnyObject>()
        var relationshipsDict = Dictionary<String, AnyObject>()
        
        if let value = data.headerBackgroundIdentifier { attributesDict["header_background_id"] = value as AnyObject? }
        if let value = data.bodyBackgroundIdentifier   { attributesDict["body_background_id"] = value as AnyObject? }
        if let value = data.fontName                   { attributesDict["font"] = value as AnyObject? }
        if let value = data.bio                        { attributesDict["bio"] = value as AnyObject? }

        if let value = data.bodyColors                 { attributesDict["body_colors"] = value.map({ $0.hexValue() })  as AnyObject? }
        if let value = data.headerColors               { attributesDict["header_colors"] = value.map({ $0.hexValue()}) as AnyObject?}
        
        if let value = data.headerCreationIdentifier
        {
            relationshipsDict["header_creation"] = ["data" : ["id" : value] as AnyObject] as AnyObject
            attributesDict["header_background_id"] = "pattern0" as AnyObject?
        }
        if let value = data.bodyCreationIdentifier
        {
            relationshipsDict["body_creation"]   = ["data" : ["id" : value] as AnyObject] as AnyObject
            attributesDict["body_background_id"] = "pattern0" as AnyObject?
        }
        
        dataDict["attributes"] = attributesDict as AnyObject?
        dataDict["relationships"] = relationshipsDict as AnyObject?
        
        return ["data" : dataDict as AnyObject]
    }
}
