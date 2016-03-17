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
    override var method: RequestMethod  { return .POST }
    override var endpoint: String
    {
        switch data.type
        {
            case .Creation: return "galleries/\(data.bubbledObjectIdentifier)/bubbles"
            case .Gallery:  return "creations/\(data.bubbledObjectIdentifier)/bubbles"
            case .User:     return "users/\(data.bubbledObjectIdentifier)/bubbles"
        }
    }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    
    private let data: NewBubbleData
    
    init(data: NewBubbleData)
    {
        self.data = data
    }
    
    private func prepareParameters() -> Dictionary<String,AnyObject>
    {
        var params = Dictionary<String,AnyObject>()
        switch data.type
        {
            case .Creation: params["creation_id"] = data.bubbledObjectIdentifier
            case .Gallery:  params["gallery_id"] = data.bubbledObjectIdentifier
            case .User:     params["user_id"] = data.bubbledObjectIdentifier
        }
        if let color = data.colorName
        {
            params["color"] = color
        }
        if let xPos = data.xPosition
        {
            params["x_pos"] = xPos
        }
        if let yPos = data.yPosition
        {
            params["y_pos"] = yPos
        }
        return params
    }
}
