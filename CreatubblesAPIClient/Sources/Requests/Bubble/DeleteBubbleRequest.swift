//
//  DeleteBubbleRequest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 17.03.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class DeleteBubbleRequest: Request
{
    override var method: RequestMethod  { return .delete }
    override var parameters: Dictionary<String, AnyObject> { return Dictionary<String,AnyObject>() }
    override var endpoint: String { return "bubbles/\(identifier)" }
    
    fileprivate let identifier: String
    init(bubbleId: String)
    {
        self.identifier = bubbleId
    }
}
