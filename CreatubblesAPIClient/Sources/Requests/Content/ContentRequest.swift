//
//  ContentRequest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 19.05.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

enum ContentType: String
{
    case Recent = "recent"
    case Trending = "trending"
}

class ContentRequest: Request
{
    override var parameters: Dictionary<String, AnyObject> { return prepareParametersDictionary() }
    override var method: RequestMethod  { return .GET }
    override var endpoint: String
    {
        return "contents/"+type.rawValue
    }
    
    private let type: ContentType
    private let page: Int?
    private let perPage: Int?
    
    init(type: ContentType, page: Int?, perPage: Int?)
    {
        self.type = type
        self.page = page
        self.perPage = perPage
        
    }
    
    func prepareParametersDictionary() -> Dictionary<String, AnyObject>
    {
        var params = Dictionary<String, AnyObject>()
        
        if let page = page
        {
            params["page"] = page
        }
        if let perPage = perPage
        {
            params["per_page"] = perPage
        }
        return params
    }
}
