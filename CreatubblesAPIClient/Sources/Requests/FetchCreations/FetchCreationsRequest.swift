//
//  FetchGalleriesRequest.swift
//  CreatubblesAPIClient
//
//  Created by Nomtek on 16.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

enum CreationsRequestSortFilter: String
{
    case Popular = "popular"
    case Recent = "recent"
}

class FetchCreationsRequest: Request
{
    override var method: RequestMethod  { return .GET }
    override var endpoint: String
    {
        if let creationId = creationId
        {
            return "creations/"+creationId
        }
        return "creations"
    }
    
    override var parameters: Dictionary<String, AnyObject> { return prepareParametersDictionary() }
    
    private let page: Int?
    private let perPage: Int?
    private let galleryId: String?
    private let userId: String?
    private let sort: CreationsRequestSortFilter?
    private let search: String?
    private let creationId: String?
    
    init(page: Int?, perPage: Int?, galleryId: String?, userId: String?, sort: CreationsRequestSortFilter?, search: String?)
    {
        self.page = page
        self.perPage = perPage
        self.galleryId = galleryId
        self.userId = userId
        self.sort = sort
        self.search = search
        self.creationId = nil
    }
    
    init(creationId: String)
    {
        self.page = nil
        self.perPage = nil
        self.galleryId = nil
        self.userId = nil
        self.sort = nil
        self.search = nil
        self.creationId = creationId

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
        if let galleryId = galleryId
        {
            params["gallery_id"] = galleryId
        }
        if let userId = userId
        {
            params["user_id"] = userId
        }
        if let sort = sort
        {
            params["sort"] = sort.rawValue
        }
        if let search = search
        {
            params["search"] = search
        }
        return params
    }
}

