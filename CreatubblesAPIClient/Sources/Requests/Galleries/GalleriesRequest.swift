//
//  GalleriesRequest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 10.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class GalleriesRequest: Request
{
    override var method: RequestMethod   { return .GET }
    override var parameters: Dictionary<String, AnyObject> { return prepareParametersDict() }
    override var endpoint: String
    {
        if let galleryId = galleryId
        {
            return "galleries/"+galleryId
        }
        return "galleries"
    }
    
    private let galleryId: String?
    private let page: Int?
    private let perPage: Int?
    private let sort: SortOrder?
    private let userId: String?
    
    init(galleryId: String)
    {
        self.galleryId = galleryId
        self.page = nil
        self.perPage = nil
        self.sort = nil
        self.userId = nil
    }
    
    init(page: Int, perPage: Int, sort: SortOrder, userId: String?)
    {
        self.galleryId = nil
        self.page = page
        self.perPage = perPage
        self.sort = sort
        self.userId = userId
    }
    
    private func prepareParametersDict() -> Dictionary<String, AnyObject>
    {
        if let _ = galleryId
        {
            return Dictionary<String, AnyObject>()
        }
        else
        {
            var dict = Dictionary<String, AnyObject>()
            if let page = page
            {
                dict["page"] = page
            }
            if let perPage = perPage
            {
                dict["per_page"] = perPage
            }
            if let sort = sort
            {
                dict["sort"] = sort.rawValue
            }
            if let userId = userId
            {
                dict["user_id"] = userId
            }
            return dict
        }
    }
}
