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
    override var method: RequestMethod   { return .PUT }
    override var endpoint: String        { return "creations/\(identifier)"   }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    
    private let identifier: String
    private let data: EditCreationData
    
    init(identifier: String, data: EditCreationData)
    {
        self.identifier = identifier
        self.data = data
    }
    
    
    private func prepareParameters() -> Dictionary<String, AnyObject>
    {
        var dataDict = Dictionary<String, AnyObject>()
        var attributesDict = Dictionary<String, AnyObject>()
        
        if let value = data.name                { attributesDict["name"] = value }
        if let value = data.reflectionText      { attributesDict["reflection_text"] = value }
        if let value = data.reflectionVideoURL  { attributesDict["reflection_video_url"] = value }
        if let value = data.creationDate
        {
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components([.Year, .Month], fromDate: value)
            
            attributesDict["created_at_year"] = components.year
            attributesDict["created_at_month"] = components.month
        }

        
        dataDict["attributes"] = attributesDict
        
        return ["data" : dataDict]
    }
}
