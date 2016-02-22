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

    private let creationData: NewCreationData
    
    
    override init()
    {
        self.creationData = NewCreationData(image: UIImage())
    }
    
    init(creationData: NewCreationData)
    {
        self.creationData = creationData
    }
    
    private func prepareParams() -> Dictionary<String, AnyObject>
    {
        var params = Dictionary<String, AnyObject>()
        if let name = creationData.name
        {
            params["name"] = name
        }
        if let creatorIds = creationData.creatorIds
        {
            params["creator_ids"] = creatorIds
        }
        if let creationMonth = creationData.creationMonth
        {
            params["created_at_month"] = creationMonth
        }
        if let creationYear = creationData.creationYear
        {
            params["created_at_year"] = creationYear
        }
        if let reflectionText = creationData.reflectionText
        {
            params["reflection_text"] = reflectionText
        }
        if let reflectionVideoUrl = creationData.reflectionVideoUrl
        {
            params["reflection_video_url"] = reflectionVideoUrl
        }
        
        return params
    }
}
