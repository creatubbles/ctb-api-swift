//
//  GallerySubmissionResponseHandler.swift
//  CreatubblesAPIClient
//
//  Created by Michal Miedlarz on 19.02.2016.
//  Copyright © 2016 Nomtek. All rights reserved.
//

import UIKit

class GallerySubmissionResponseHandler: ResponseHandler
{
    private let completion: ErrorClousure?
    init(completion: ErrorClousure?)
    {
        self.completion = completion
    }
    
    override func handleResponse(response: Dictionary<String, AnyObject>?, error: ErrorType?)
    {
        completion?(error)
    }    
}
