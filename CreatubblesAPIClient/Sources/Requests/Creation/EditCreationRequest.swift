//
//  EditCreationRequest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 15.06.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class EditCreationRequest: Request
{
    override var method: RequestMethod   { return .put }
    override var endpoint: String        { return "creations/\(identifier)"   }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    
    fileprivate let identifier: String
    fileprivate let data: EditCreationData
    
    init(identifier: String, data: EditCreationData)
    {
        self.identifier = identifier
        self.data = data
    }
    
    
    fileprivate func prepareParameters() -> Dictionary<String, AnyObject>
    {
        var dataDict = Dictionary<String, AnyObject>()
        var attributesDict = Dictionary<String, AnyObject>()
        
        if let value = data.name                { attributesDict["name"] = value as AnyObject? }
        if let value = data.reflectionText      { attributesDict["reflection_text"] = value as AnyObject? }
        if let value = data.reflectionVideoURL  { attributesDict["reflection_video_url"] = value as AnyObject? }
        if let value = data.creationDate
        {
            let calendar = Calendar.current
            let components = (calendar as NSCalendar).components([.year, .month], from: value as Date)
            
            attributesDict["created_at_year"] = components.year as AnyObject?
            attributesDict["created_at_month"] = components.month as AnyObject?
        }

        
        dataDict["attributes"] = attributesDict as AnyObject?
        
        return ["data" : dataDict as AnyObject]
    }
}
