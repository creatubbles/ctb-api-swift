//
//  FavoriteGalleriesRequest.swift
//  CreatubblesAPIClient
//
//  Created by Dawid Płatek on 06.09.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class FavoriteGalleriesRequest : Request {
    override var method: RequestMethod { return .GET }
    override var parameters: Dictionary<String, AnyObject> { return prepareParameters() }
    override var endpoint: String { return "users/me/favorite_galleries" }
    
    private let page: Int?
    private let perPage: Int?
    
    init(page: Int?, perPage: Int?) {
        self.page = page
        self.perPage = perPage
    }
    
    private func prepareParameters() -> Dictionary<String,AnyObject> {
        var params = Dictionary<String,AnyObject>()
        if let page = page {
            params["page"] = page
        }
        
        if let perPage = perPage {
            params["per_page"] = perPage
        }
        
        return params
    }
}