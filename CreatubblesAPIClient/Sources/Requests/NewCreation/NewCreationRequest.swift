//
//  NewCreationRequest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 12.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class NewCreationRequest: Request
{
    override var method: RequestMethod  { return .POST }
    override var endpoint: String       { return "creations" }
    override var parameters: Dictionary<String, AnyObject> { return prepareParams() }
    
    private let name: String?
    private let creatorIds: Array<String>?
    private let creationMonth: Int?
    private let creationYear: Int?
    private let reflectionText: String?
    private let reflectionVideoUrl: String?
    
    init(name: String? = nil, creatorIds: Array<String>? = nil, creationYear: Int? = nil, creationMonth: Int? = nil, reflectionText: String? = nil, reflectionVideoUrl: String? = nil)
    {
        self.name = name
        self.creatorIds = creatorIds
        self.creationYear = creationYear
        self.creationMonth = creationMonth
        self.reflectionText = reflectionText
        self.reflectionVideoUrl = reflectionVideoUrl
    }
    
    private func prepareParams() -> Dictionary<String, AnyObject>
    {
        var params = Dictionary<String, AnyObject>()
        if let name = name
        {
            params["name"] = name
        }
        if let creatorIds = creatorIds
        {
            params["creator_ids"] = creatorIds
        }
        if let creationMonth = creationMonth
        {
            params["created_at_month"] = creationMonth
        }
        if let creationYear = creationYear
        {
            params["created_at_year"] = creationYear
        }
        if let reflectionText = reflectionText
        {
            params["reflection_text"] = reflectionText
        }
        if let reflectionVideoUrl = reflectionVideoUrl
        {
            params["reflection_video_url"] = reflectionVideoUrl
        }
        
        return params
    }
}
