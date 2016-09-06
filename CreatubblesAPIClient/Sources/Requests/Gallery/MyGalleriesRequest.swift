//
//  MyGalleriesRequest.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek  on 04.09.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

enum MyGalleriesRequestFilter {
    case None
    case Owned
    case Shared
}

class MyGalleriesRequest  : Request {
    override var method: RequestMethod { return .GET }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    override var endpoint: String       { return "users/me/galleries" }
    
    private let page: Int?
    private let perPage: Int?
    private let filter: MyGalleriesRequestFilter
    
    init(page: Int?, perPage: Int?, filter: MyGalleriesRequestFilter?) {
        self.page = page
        self.perPage = perPage
        self.filter = filter ?? .None
    }
    
    private func prepareParameters() -> Dictionary<String,AnyObject> {
        var params = Dictionary<String,AnyObject>()
        if let page = page {
            params["page"] = page
        }
        
        if let perPage = perPage {
            params["per_page"] = perPage
        }
        
        switch filter {
        case .Owned:
            params["gallery_filter"] = "only_owned"
        case .Shared:
            params["gallery_filter"] = "only_shared"
        default: break
        }
        
        return params
    }
}