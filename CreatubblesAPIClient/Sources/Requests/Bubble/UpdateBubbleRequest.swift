//
//  UpdateBubbleRequest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 17.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class UpdateBubbleRequest: Request
{
    override var method: RequestMethod  { return .put }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    override var endpoint: String { return "bubbles/\(data.identifier)" }
    
    fileprivate let data: UpdateBubbleData
    init(data: UpdateBubbleData)
    {
        self.data = data
    }
    
    fileprivate func prepareParameters() -> Dictionary<String,AnyObject>
    {
        var params = Dictionary<String,AnyObject>()
        params["id"] = data.identifier as AnyObject?
        
        if let color = data.colorName
        {
            params["color"] = color as AnyObject?
        }
        return params
    }
}
