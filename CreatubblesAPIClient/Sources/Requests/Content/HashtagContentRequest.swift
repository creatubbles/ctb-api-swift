//
//  HashtagContentRequest.swift
//  CreatubblesAPIClient
//
//  Created by Lorenzo Greco on 26/01/2018.
//  Copyright © 2018 Nomtek. All rights reserved.
//

class HashtagContentRequest: Request {
    override var parameters: Dictionary<String, AnyObject> { return prepareParametersDictionary() }
    override var method: RequestMethod { return .get }
    override var endpoint: String {
        return "hashtags/"+hashtagName+"/contents"
    }
    
    fileprivate let page: Int?
    fileprivate let perPage: Int?
    fileprivate let hashtagName: String
    
    init(hashtagName: String, page: Int?, perPage: Int?) {
        self.page = page
        self.perPage = perPage
        self.hashtagName = hashtagName
    }
    
    func prepareParametersDictionary() -> Dictionary<String, AnyObject> {
        var params = Dictionary<String, AnyObject>()
        
        if let page = page {
            params["page"] = page as AnyObject?
        }
        if let perPage = perPage {
            params["per_page"] = perPage as AnyObject?
        }
        
        return params
    }
}
