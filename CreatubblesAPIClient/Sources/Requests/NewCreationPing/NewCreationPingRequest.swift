//
//  NewCreationPingRequest.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 17.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class NewCreationPingRequest: Request
{
    override var method: RequestMethod   { return .PUT }
    override var endpoint: String { return "uploads/"+uploadId }
    override var parameters: Dictionary<String, AnyObject>
    {
        if let err = abortError
        {
            return ["aborted_with":err]
        }
        return Dictionary<String, AnyObject>()
    }
    
    private let uploadId: String
    private let abortError: String?
    
    init(uploadId: String, abortError: String? = nil)
    {
        self.uploadId = uploadId
        self.abortError = abortError
    }
}
