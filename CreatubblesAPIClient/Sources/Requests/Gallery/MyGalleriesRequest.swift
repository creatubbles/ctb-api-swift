//
//  MyGalleriesRequest.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek  on 04.09.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

enum MyGalleriesRequestFilter {
    case none
    case owned
    case shared
}

class MyGalleriesRequest  : Request {
    override var method: RequestMethod { return .get }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    override var endpoint: String       { return "users/me/galleries" }
    
    fileprivate let page: Int?
    fileprivate let perPage: Int?
    fileprivate let filter: MyGalleriesRequestFilter
    
    init(page: Int?, perPage: Int?, filter: MyGalleriesRequestFilter?) {
        self.page = page
        self.perPage = perPage
        self.filter = filter ?? .none
    }
    
    fileprivate func prepareParameters() -> Dictionary<String,AnyObject> {
        var params = Dictionary<String,AnyObject>()
        if let page = page {
            params["page"] = page as AnyObject?
        }
        
        if let perPage = perPage {
            params["per_page"] = perPage as AnyObject?
        }
        
        switch filter {
        case .owned:
            params["gallery_filter"] = "only_owned" as AnyObject?
        case .shared:
            params["gallery_filter"] = "only_shared" as AnyObject?
        default: break
        }
        
        return params
    }
}
