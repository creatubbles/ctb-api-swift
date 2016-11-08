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
    case BubbledContents = "bubbled_contents"
    case Connected = "connected"
    case ContentsByAUser = "contents"
    case Followed = "followed"
}

class ContentRequest: Request
{
    override var parameters: Dictionary<String, AnyObject> { return prepareParametersDictionary() }
    override var method: RequestMethod  { return .get }
    override var endpoint: String
    {
        if  type == .BubbledContents,
            let identifier = userId
        {
            return "users/\(identifier)/bubbled_contents"
        }
        else if type == .ContentsByAUser,
            let identifier = userId
        {
            return "users/\(identifier)/contents"
        }
        
        return "contents/"+type.rawValue
    }
    
    fileprivate let type: ContentType
    fileprivate let page: Int?
    fileprivate let perPage: Int?
    fileprivate let userId: String?
    
    init(type: ContentType, page: Int?, perPage: Int?, userId: String? = nil)
    {
        assert( (type == .BubbledContents && userId == nil) == false, "userId cannot be nil for BubbledContents")
        self.type = type
        self.page = page
        self.perPage = perPage
        self.userId = userId
    }
    
    func prepareParametersDictionary() -> Dictionary<String, AnyObject>
    {
        var params = Dictionary<String, AnyObject>()
        
        if let page = page
        {
            params["page"] = page as AnyObject?
        }
        if let perPage = perPage
        {
            params["per_page"] = perPage as AnyObject?
        }
        
        return params
    }
}
