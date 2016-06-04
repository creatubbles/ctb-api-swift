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
        var params = Dictionary<String, AnyObject>()
        if let value = data.headerBackgroundIdentifier { params["header_background_id"] = value }
        if let value = data.bodyBackgroundIdentifier { params["body_background_id"] = value }
        if let value = data.fontName { params["font"] = value }
        if let value = data.bio { params["bio"] = value }
        if let value = data.bodyColors { params["body_colors"] = value.map({ $0.hexValue() }) }
        if let value = data.headerColors { params["header_colors"] = value.map({ $0.hexValue() }) }
        
        return params
    }
}
