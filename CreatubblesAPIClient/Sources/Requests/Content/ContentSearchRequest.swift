//
//  ContentSearchRequest.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 25.07.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class ContentSearchRequest: Request
{
    override var method: RequestMethod   { return .GET }
    override var endpoint: String        { return "contents?query=\(query)"   }
    override var parameters: Dictionary<String, AnyObject> { return prepareParametersDictionary() }

    private let query: String
    private let page: Int?
    private let perPage: Int?
    
    init(query: String, page: Int?, perPage: Int?)
    {
        self.query = query
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
