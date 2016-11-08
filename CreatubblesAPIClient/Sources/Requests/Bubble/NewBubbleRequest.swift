//
//  NewBubbleRequest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 17.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class NewBubbleRequest: Request
{
    override var method: RequestMethod  { return .post }
    override var endpoint: String
    {
        switch data.type
        {
            case .creation: return "creations/\(data.bubbledObjectIdentifier)/bubbles"
            case .gallery:  return "galleries/\(data.bubbledObjectIdentifier)/bubbles"
            case .user:     return "users/\(data.bubbledObjectIdentifier)/bubbles"
        }
    }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    
    fileprivate let data: NewBubbleData
    
    init(data: NewBubbleData)
    {
        self.data = data
    }
    
    fileprivate func prepareParameters() -> Dictionary<String,AnyObject>
    {
        var params = Dictionary<String,AnyObject>()
        switch data.type
        {
            case .creation: params["creation_id"] = data.bubbledObjectIdentifier as AnyObject?
            case .gallery:  params["gallery_id"] = data.bubbledObjectIdentifier as AnyObject?
            case .user:     params["user_id"] = data.bubbledObjectIdentifier as AnyObject?
        }
        if let color = data.colorName
        {
            params["color"] = color as AnyObject?
        }
        if let xPos = data.xPosition
        {
            params["x_pos"] = xPos as AnyObject?
        }
        if let yPos = data.yPosition
        {
            params["y_pos"] = yPos as AnyObject?
        }
        return params
    }
}
